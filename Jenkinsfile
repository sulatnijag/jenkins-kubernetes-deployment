pipeline {
  agent any

  stages {

    stage('docker build') {
      steps {

          script{
            sh 'docker build .'
          }

      }
    }
  }
}