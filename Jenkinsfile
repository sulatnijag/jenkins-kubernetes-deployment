pipeline {
  agent any

  stages {

    stage('docker build') {
      steps {

          script{
            dockerImage = docker.build("sulatnijag/testimage", "-f Dockerfile .")
          }

      }
    }
  }
}