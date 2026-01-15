pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Construir Docker') {
            steps {
                sh 'docker build -t pichichi:latest .'
            }
        }

        stage('Test Sintaxis') {
            steps {
                sh 'python3 -m py_compile pichichi.py'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'scanner'
                    withSonarQubeEnv('SonarQube') { 
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Despliegue de Prueba') {
            steps {
                script {
                    try {
                        sh 'docker run -d --name test_pichichi pichichi:latest'
                        sh 'sleep 5'
                        sh 'docker logs test_pichichi'
                    } finally {
                        sh 'docker rm -f test_pichichi'
                    }
                }
            }
        }
    }
}
