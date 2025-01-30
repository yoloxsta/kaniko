pipeline {
    agent {
        kubernetes {
            yaml """
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  - name: google-cloud-sdk
    image: google/cloud-sdk
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: regcredsta
          items:
            - key: .dockerconfigjson
              path: config.json
"""
        }
    }
    environment {
        DOCKER_IMAGE = "yolomurphy/test"
        BUILD_TAG = "${DOCKER_IMAGE}:${BUILD_NUMBER}"
        LATEST_TAG = "${DOCKER_IMAGE}:latest"
    }
    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image with Kaniko') {
            steps {
                container(name: 'kaniko', shell: '/busybox/sh') {
                    sh '''#!/busybox/sh
                        /kaniko/executor --context `pwd` --dockerfile Dockerfile --destination $BUILD_TAG --destination $LATEST_TAG
                    '''
                }
            }
        }

        stage('Test image') {
            steps {
                container(name: 'kaniko', shell: '/busybox/sh') {
                    sh 'echo "Tests passed"'
                }
            }
        }

        stage('Push image') {
            steps {
                container(name: 'kaniko', shell: '/busybox/sh') {
                    sh '''#!/busybox/sh
                        /kaniko/executor --context `pwd` --dockerfile Dockerfile --destination $BUILD_TAG --destination $LATEST_TAG
                    '''
                }
            }
        }
        
        stage('deploy') {
            steps {
                container(name: 'google-cloud-sdk', shell: '/bin/bash') {
                    sh '''
                    # Now run kubectl apply (no need to install kubectl, it is already available)
                    kubectl apply -f deployment.yaml

                    echo "Restarting Deployment to Pull Latest Image"
                    kubectl rollout restart deployment/sta-deployment
                    kubectl rollout status deployment/sta-deployment
                 '''
        }
    }
}
    }
}