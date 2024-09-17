pipeline {
    agent any
    parameters {
        string(name: 'ENVIRONMENT', defaultValue: 'development', description: 'Deployment Environment (development, SIT)')
    }
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
        stage('Deploy') {
            steps {
                script {
                    if (params.ENVIRONMENT == 'development') {
                        echo "Deploying to Development environment"
                        // Add deployment commands for development
                        bat 'deploy-dev.bat'
                    } else if (params.ENVIRONMENT == 'SIT') {
                        echo "Deploying to SIT environment"
                        // Add deployment commands for SIT
                        bat 'deploy-sit.bat'
                    } else {
                        error "Invalid environment: ${params.ENVIRONMENT}"
                    }
                }
            }
        }
    }
}
