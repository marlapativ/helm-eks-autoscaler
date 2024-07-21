# NOTE: This Dockerfile is used to mirror the image for the cluster-autoscaler
#       Update the tag on Jenkinsfile to override the docker image tag

ARG BASEIMAGETAG=v1.30.0
FROM registry.k8s.io/autoscaling/cluster-autoscaler:${BASEIMAGETAG}
