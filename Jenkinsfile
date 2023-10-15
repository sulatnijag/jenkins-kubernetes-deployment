pipeline {

  environment {
    dockerimagename = "sulatnijag/node-app"
    dockerImage = ""
  }
  
  options {
    skipStagesAfterUnstable()
  }
  
  agent any
  
  stages {

    stage('Docker Build') { 
      steps { 
        script{
          def customImage = docker.build("sulatnijag/node-app:${env.BUILD_ID}")
        }
      }
    }


  }
}