podTemplate(yaml: '''
kind: Pod
metadata:
  name: kaniko
  namespace: jenkins
spec:
  containers:
  - name: kubectl
    image: sulatnijag/xdork-agent:latest
    resources:
      requests:
        memory: "256"
        cpu: "250m"
      limits:
        memory: "1024Mi"
        cpu: "500m"
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
    resources:
      requests:
        memory: "512Mi"
        cpu: "250m"
      limits:
        memory: "1024Mi"
        cpu: "500m"


  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: docker-credentials
          items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('Checkout GIT branch'){
        container('jnlp'){
           git url: 'https://github.com/sulatnijag/jenkins-kubernetes-deployment.git', branch: 'main' 
        }
    }
      
    stage('Build and push image') {
      container(name: 'kaniko', shell: '/busybox/sh') {
          sh '''#!/busybox/sh
            /kaniko/executor --context `pwd` --destination sulatnijag/jenkinstest:latest
          '''
      }
    }
    
    stage('Deploy container') {
      container('kubectl') {
          sh '''
            kubectl get pods -A
          '''
      }
    }

  }
}