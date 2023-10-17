pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credential')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t sulatnijag/jenkinstest:latest .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push sulatnijag/jenkinstest:latest'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}