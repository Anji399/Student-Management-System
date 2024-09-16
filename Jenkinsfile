pipeline {
    agent any 
    stages {
        stage('checkout') {
            steps{
                script {
                    git changelog: false, url: 'https://github.com/Anji399/Student-Management-System.git'
                }    
            }
        }
        stage('build'){
            steps {
                script {
                    bat 'mvn clean install'
                }    
            }    
        }
        stage('deploy'){
            steps {
                script {
                    bat 'cd C:/Users/user/.jenkins/workspace/SMS/target/ && java -jar student-management-0.0.1-SNAPSHOT.jar'


                }
            }
        }
    }
}