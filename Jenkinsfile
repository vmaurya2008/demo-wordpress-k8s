pipeline {
  agent any

  environment {
    REGISTRY = "docker.io/vmaurya2008"
    APP_NAME = "wordpress"
    VERSION = "v1.0.0"
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/vmaurya2008/demo-wordpress-k8s.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${REGISTRY}/${APP_NAME}:${VERSION}")
        }
      }
    }

    stage('Push Image') {
      steps {
        withDockerRegistry([credentialsId: 'dockerhub-creds', url: 'https://index.docker.io/v1/']) {
          script {
            docker.image("${REGISTRY}/${APP_NAME}:${VERSION}").push()
          }
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/'
      }
    }
  }

  post {
    failure {
      echo 'Build failed. Consider rollback.'
    }
  }
}
