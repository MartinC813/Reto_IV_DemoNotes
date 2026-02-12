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
        script {
          docker.build("${FULL_IMAGE}:${BUILD_NUMBER}")
        }
      }
    }

    stage("Login Docker Hub") {
      steps {
        withDockerRegistry(credentialsId: "dockerhub-creds", url: "") {
          echo "Login exitoso"
        }
      }
    }

    stage("Push Docker Image") {
      steps {
        script {
          docker.image("${FULL_IMAGE}:${BUILD_NUMBER}").push()
          docker.image("${FULL_IMAGE}:${BUILD_NUMBER}").push("latest")
        }
      }
    }

    stage("Deploy a Kubernetes (Rolling Update)") {
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
