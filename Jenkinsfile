pipeline {
    environment {
        imageRegistry = "docker.io"
        imageRepo = "marlapativ"
        dockerimageName = "eks-autoscaler"
        dockerimageTag = "v1.30.0"
        registryCredential = 'dockerhub'
    }
    agent any
    stages {
        stage('helm chart validations') {
            steps {
                sh '''
                    helm dependency update
                    helm lint . --strict
                    helm template .
                '''
            }
        }

        stage('setup docker') {
            steps {
                sh '''
                    if [ -n "$(docker buildx ls | grep multiarch)" ]; then
                        docker buildx use multiarch
                    else
                        docker buildx create --name=multiarch --driver=docker-container --use --bootstrap 
                    fi
                '''
                
                script {
                    withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'password', usernameVariable: 'username')]) {
                        sh('docker login -u $username -p $password')
                    }
                }
            }
        }

        stage('build cluster-autoscaler image') {
            steps {
                sh '''
                    docker buildx build \
                        --build-arg BASEIMAGETAG=$dockerimageTag \
                        --platform linux/amd64,linux/arm64 \
                        --builder multiarch \
                        -t $imageRepo/$dockerimageName:latest \
                        -t $imageRepo/$dockerimageName:$dockerimageTag \
                        --push \
                        .
                '''
            }
        }

        stage('github release') {
            tools {
                nodejs "nodejs"
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-app', passwordVariable: 'GITHUB_TOKEN', usernameVariable: 'GITHUB_USERNAME')]) {
                        sh '''
                            npm i -g @semantic-release/exec
                            export GITHUB_ACTION=true
                            npx semantic-release
                        '''
                    }
                }
            }
        }

        stage('dockerhub release') {
            steps {
                script {
                    sh '''
                        helm push helm-eks-autoscaler-*.tgz oci://$imageRegistry/$imageRepo
                    '''
                }
            }
        }
    }
}
