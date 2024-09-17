pipeline {
    agent any
    parameters {
        string(name: 'ENVIRONMENT', defaultValue: 'development', description: 'Deployment Environment (development, SIT)')
    }
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
                    bat 'mvn clean install'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Deploying to ${params.ENVIRONMENT} environment"
                    bat "java -jar target/your-app.jar --spring.profiles.active=${params.ENVIRONMENT}"
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
