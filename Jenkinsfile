pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: "jnlp"
            resources:
              requests:
                memory: "1Gi"
                cpu: "200m"
          - name: docker
            image: docker:latest
            resources:
              requests:
                memory: "512Mi"
                cpu: "200m"
            volumeMounts:
              - name: dind-storage
                mountPath: /var/lib/docker
            securityContext:
              privileged: true
          volumes:
            - name: dind-storage
              emptyDir: {}
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


    stage('Initialize') {
      steps {
        container('jnlp') {
          sh 'sleep 60'
        }
      }
    }

  stage('Apply Kubernetes files') {
    steps {
      withKubeConfig([credentialsId: 'user1', serverUrl: 'https://api.k8s.my-company.com']) {
        sh 'kubectl apply -f deployment.yaml'
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