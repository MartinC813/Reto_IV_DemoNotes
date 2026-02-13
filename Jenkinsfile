pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:latest
"""
    }
  }

  stages {
    stage('Random Task') {
      steps {
        sh 'echo Hola desde un pod efímero'
        sh 'date'
        sh 'uname -a'
      }
    }
  }
}
