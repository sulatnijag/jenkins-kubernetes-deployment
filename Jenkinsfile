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
          dockerImage = docker.build dockerimagename
          def customImage = docker.build("sulatnijag/node-app:${env.BUILD_ID}")
        }
      }
    }


  }
}