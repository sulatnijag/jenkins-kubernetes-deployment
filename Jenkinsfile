pipeline {
  agent any

  stages {
    stage('Build Image') {
      steps {
        script {
            sh 'docker build -t sulatnijag/testimage .'
        }
      }
    }
  }
}