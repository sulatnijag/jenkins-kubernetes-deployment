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

    stage('Clone repository') { 
      steps { 
        script{
          checkout scm
        }
      }
    }

    stage('Docker Build') { 
      steps { 
        script{
          dockerImage = docker.build dockerimagename
        }
      }
    }


  }
}