pipeline {
    agent any

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Git Checkout') {
            steps {
                git branch: 'main', changelog: false, credentialsId: 'github-sa', poll: false, url: 'https://github.com/fastest-man-alive/hotwheels-collection.git'
            }
        }
        stage('End') {
            steps {
                echo "Git Clone comppleted"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying ...'
            }
        }
    }
}