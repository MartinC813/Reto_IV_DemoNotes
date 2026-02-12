pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: tools
    image: alpine:3.20
    command:
      - cat
    tty: true
"""
    }
  }

  stages {
    stage('Info del sistema') {
      steps {
        container('tools') {
          sh '''
            echo "Usuario:"
            whoami

            echo "Kernel:"
            uname -a

            echo "Fecha:"
            date
          '''
        }
      }
    }

    stage('Random task') {
      steps {
        container('tools') {
          sh '''
            echo "Numero random:"
            echo $RANDOM

            echo "Listando archivos:"
            ls -la
          '''
        }
      }
    }

    stage('Simular build') {
      steps {
        container('tools') {
          sh '''
            echo "Simulando build..."
            sleep 2
            echo "Build completa"
          '''
        }
      }
    }
  }
}
