pipeline {
    agent any
    environment {
        SONAR_TOKEN = credentials('sonarqube')
    }
    tools {
        nodejs 'NodeJS'
        maven 'Maven'
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

        stage('SonarCloud Analysis') {
            steps {
                withSonarQubeEnv('SonarCloud') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=madhu-s-joshi_node-jenkins -Dsonar.organization=madhu.s.joshi -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 1, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
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
                        sh '/usr/local/bin/docker login -u $DOCKER_USER -p $DOCKER_PASS'
                        sh '/usr/local/bin/docker tag my-node-app:1.0 madhusjoshi/node-app:1.0'
                        sh '/usr/local/bin/docker push madhusjoshi/node-app:1.0'
                        sh '/usr/local/bin/docker logout'
                    }
            }
        }
    }
}