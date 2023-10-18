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
            command:
            - cat
            tty: true
            volumeMounts:
            - mountPath: /var/run/docker.sock
              name: docker-sock
          
          volumes:
            - name: docker-sock
              hostPath:
                path: /var/run/docker.sock
        '''
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credential')
  }
  stages {
    stage('Build') {
      steps {
        container('docker') {
          sh 'sudo systemctl start docker'
          sh 'sleep 30'
          sh 'docker --version'
          sh 'docker build -t sulatnijag/jenkinstest:latest .'
        }
      }
    }
    stage('Login') {
      steps {
        container('docker') {
          sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        }
      }
    }
    stage('Push') {
      steps {
        container('docker') {
          sh 'docker push sulatnijag/jenkinstest:latest'
        }
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}