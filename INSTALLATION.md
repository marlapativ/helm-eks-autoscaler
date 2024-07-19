# Helm Installation Guide

## Introduction

Helm is a package manager for Kubernetes that simplifies the deployment and management of applications on your Kubernetes cluster. This guide will walk you through the installation process for Helm on different operating systems.

## Prerequisites

- A Kubernetes cluster
- `kubectl` installed and configured to communicate with your cluster

## Installing Helm

### Linux

1. Download the latest Helm binary:

    ```sh
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
   chmod 700 get_helm.sh
   ./get_helm.sh
   ```

2. Verify the installation:

    ```sh
    helm version
    ```

### MacOS

1. Install Helm using Homebrew:

    ```sh
    brew install helm
    ```

2. Verify the installation:

    ```sh
    helm version
    ```

### Windows

1. Download the latest Helm binary from the [Helm GitHub repository](https://github.com/helm/helm/releases)
2. Unzip the downloaded file and add the `helm` binary to your PATH
3. Verify the installation:

    ```sh
    helm version
    ```
