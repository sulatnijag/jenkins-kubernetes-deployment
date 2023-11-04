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

    stage('Apply Kubernetes files') {
      withKubeConfig([credentialsId: '2e5c14e5-af88-40fb-a793-6efef5716bff', serverUrl: 'https://kubernetes.default']) {
        sh 'kubectl apply -f service.yaml'
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