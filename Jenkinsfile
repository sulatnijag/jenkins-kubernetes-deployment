pipeline {
  agent any

  stages {

        stage('Build and Push Docker Image...') {
          steps {
                script {
                  // DOCKER HUB
                  
                  /* Build the container image */            
                  def dockerImage = docker.build("my-image:${env.BUILD_ID}")
                        
                  /* Push the container to the docker Hub */
                  //dockerImage.push()

                  /* Remove docker image*/
                  //sh 'docker rmi -f my-image:${env.BUILD_ID}'

                } 
            } 
        }

  }
}