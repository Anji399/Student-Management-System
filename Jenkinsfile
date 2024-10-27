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
                        bat 'mvn clean install deploy -Dspring.profiles.active=windows'
                    }
                }
            }
        }
        stage('Upload artifacts to Nexus'){
            steps {
                script {
                   nexusArtifactUploader artifacts: [[artifactId: 'student-management', classifier: '', file: 'target/student-management-0.0.1-SNAPSHOT.war', type: 'war']], credentialsId: 'nexus', groupId: 'com.burak', nexusUrl: '13.233.65.176:8081/nexus', nexusVersion: 'nexus3', protocol: 'http', repository: 'calculator', version: '0.0.1-SNAPSHOT'
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
                        bat '''
                        "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -u root -pPrasanna@9334 -e "USE spring_security_custom_user_demo; INSERT INTO role (name) VALUES ('ROLE_STUDENT'); INSERT INTO role (name) VALUES ('ROLE_TEACHER');"
                        '''
                    }
                }
            }
        }
        stage('Approval') {
            steps {
                script {
                    // Request manual approval before deployment
                    input message: 'Do you want to proceed with the deployment?', ok: 'Deploy'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                   deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://localhost:8086/')], contextPath: null, war: 'target/*.war'
                }
            }
        }
    }
}
