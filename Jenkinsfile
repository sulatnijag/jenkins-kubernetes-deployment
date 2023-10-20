pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: docker
            image: docker:latest
            volumeMounts:
              - name: dind-storage
                mountPath: /var/lib/docker
            securityContext:
              privileged: true

          volumes:
            - name: dind-storage
              mptyDir: {}
        '''
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credential')
  }
  stages {


    stage('Init') {
      steps {

        container('jnlp') {
          sh 'sleep 60'
        }

      }

    }


    stage('Build') {
      steps {
        container('docker') {
          sh 'docker --version'
          sh 'sleep 36'
          retry(5) {
            sh 'sleep 5'
            sh 'docker build -t sulatnijag/jenkinstest:latest .'
          }
        }
      }
    }

    stage('Login') {

      steps {
        container('docker') {
          retry(5) {
            sh 'sleep 5'
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
          }
        }
      }

    }
    stage('Push') {
      steps {
        container('docker') {
          retry(5) {
            sh 'sleep 5'
            sh 'docker push sulatnijag/jenkinstest:latest'
          }
        }
      }
    }
  }
  post {
    always {
      container('docker') {
        retry(5) {
          sh 'sleep 5'
          sh 'docker logout'
        }
      }
    }
  }
}