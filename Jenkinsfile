pipeline {
    agent {
        docker {
            image 'docker:dind'
            args '--privileged'
        }
    }
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
    }
}