pipeline {
    agent any
    tools {
        nodejs 'NodeJS'
    }
    stages{
        stage("checkout"){
            steps{
                checkout scm
            }
        }

        stage("Test"){
            steps{
                sh 'npm test'
            }
        }

        stage("Build"){
            steps{
                sh 'npm run build'
            }
        }

        stage("Build Image"){
            steps{
                sh '/usr/local/bin/docker build -t my-node-app:1.0 .'
            }
        }

        stage("Docker Image Push"){
            steps{
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                        sh 'docker tag my-node-app:1.0 madhusjoshi/node-app:1.0'
                        sh 'docker push madhusjoshi/node-app:1.0'
                        sh 'docker logout'
                    }
            }
        }
    }
}