pipeline {
    agent any
    stages{
        stage("checkout"){
            step{
                checkout scm
            }
        }

        stage("Test"){
            step{
                sh 'sudo apt install npm'
                sh 'npm test'
            }
        }

        stage("Build"){
            step{
                sh 'npm run build'
            }
        }
    }
}