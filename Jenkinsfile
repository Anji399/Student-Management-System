pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
                    git changelog: false, url: 'https://github.com/Anji399/Student-Management-System.git'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    sh 'mvn clean install'
                }
            }
        }
        stage('Deploy') {
           steps {
             script {
                    sh 'cp /target/*.jar /opt/tomcat/latest/webapps/ROOT.jar'
             }
          }
       }
    }
}
