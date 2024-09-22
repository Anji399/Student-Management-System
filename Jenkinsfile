pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')  
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
                    if (isUnix()) {
                        // Run on Linux with the 'linux' profile
                        sh 'mvn clean install -Dspring.profiles.active=linux'
                    } else {
                        // Run on Windows with the 'windows' profile
                        bat 'mvn clean install -Dspring.profiles.active=windows'
                    }
                }
            }
        }
        stage('Insert Roles into Database') {
            steps {
                script {
                    if (isUnix()) {
                        // MySQL commands for Linux to insert roles into the database
                        sh '''
                        mysql -u root -pPrasanna@2024 -e "
                        USE spring_security_custom_user_demo;
                        INSERT INTO role (name) VALUES ('ROLE_STUDENT');
                        INSERT INTO role (name) VALUES ('ROLE_TEACHER');
                        "
                        '''
                    } else {
                        // MySQL commands for Windows to insert roles into the database
                        // Ensure that mysql.exe is in PATH, or provide the full path to mysql.exe
                        bat '''
                        "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -u root -pPrasanna@9334 -e "USE spring_security_custom_user_demo; INSERT INTO role (name) VALUES ('ROLE_STUDENT'); INSERT INTO role (name) VALUES ('ROLE_TEACHER');"
                        '''
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (isUnix()) {
                        // Deployment for Linux
                        sh 'sudo cp /var/lib/jenkins/workspace/Student-Management/target/student-management-0.0.1-SNAPSHOT.jar /opt/tomcat/latest/webapps/student-management.jar'
                    } else {
                        // Deployment for Windows
                        bat 'copy "C:\\Users\\user\\.jenkins\\workspace\\Student MS\\target\\student-management-0.0.1-SNAPSHOT.jar" "C:\\Program Files\\apache-tomcat-9.0.89\\webapps\\SMS.jar"'
                    }
                }
            }
        }
    }
}
