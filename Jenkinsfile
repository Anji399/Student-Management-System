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
                        echo "Starting the backend in the background..."
                        // Start the application in the background
                        bat "start /B java -jar ${jarPath}"

                        // Wait for the app to start (give it some buffer time, e.g., 10 seconds)
                        sleep(time: 10, unit: 'SECONDS')

                        // Check if the application is up by calling the health endpoint (or root URL)
                        def response = bat(returnStdout: true, script: 'curl -I http://localhost:8099')
                        
                        // If the response contains "200 OK", the app is up and running
                        if (response.contains("200 OK")) {
                            echo "Application is running successfully!"
                        } else {
                            error "Application failed to start. Check logs for more details."
                        }
                    } else {
                        error "JAR file not found at ${jarPath}. Ensure the build step succeeded."
                    }
                }
            }
        }
    }
}
