pipeline {
  agent any

  environment {
    DOCKER_USER = "martinc813"
    IMAGE_NAME = "notes-api"
    FULL_IMAGE = "${DOCKER_USER}/${IMAGE_NAME}"
    K8S_DEPLOYMENT = "my-api-deployment"
    K8S_CONTAINER = "my-api"
  }

  stages {

    stage("Clonar repo") {
      steps {
        checkout scm
      }
    }

    stage("Build Docker Image") {
      steps {
        sh "docker build -t ${FULL_IMAGE}:${BUILD_NUMBER} ."
      }
    }

    stage("Login Docker Hub") {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
        }
      }
    }

    stage("Push Docker Image") {
      steps {
        sh """
          docker push ${FULL_IMAGE}:${BUILD_NUMBER}
          docker tag ${FULL_IMAGE}:${BUILD_NUMBER} ${FULL_IMAGE}:latest
          docker push ${FULL_IMAGE}:latest
        """
      }
    }

    stage("Deploy Kubernetes") {
      steps {
        sh """
          kubectl set image deployment/${K8S_DEPLOYMENT} \
          ${K8S_CONTAINER}=${FULL_IMAGE}:${BUILD_NUMBER}
        """
      }
    }

    stage("Verificar rollout") {
      steps {
        sh "kubectl rollout status deployment/${K8S_DEPLOYMENT}"
      }
    }
  }
}
