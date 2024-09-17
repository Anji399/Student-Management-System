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
        stage('deploy') {
            steps {
                script {
                    // Ensure correct directory and file path
                    def jarPath = 'C:/Users/user/.jenkins/workspace/SMS/target/student-management-0.0.1-SNAPSHOT.jar'
                    
                    // Check if the JAR file exists before running it
                    if (fileExists(jarPath)) {
                        echo "Starting the backend..."
                        bat "java -jar ${jarPath}"
                    } else {
                        error "JAR file not found at ${jarPath}. Ensure the build step succeeded."
                    }
                }
            }
        }
    }
}
