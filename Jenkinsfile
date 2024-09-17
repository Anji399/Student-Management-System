pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                script {
                    git changelog: false, url: 'https://github.com/Anji399/Student-Management-System.git'
                }
            }
        }
        stage('build') {
            steps {
                script {
                    bat 'mvn clean install'
                }
            }
        }
    }
}
