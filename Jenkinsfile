pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        
        stage('Construir Docker (Fase 1)') {
            steps {
                sh 'docker build -t pichichi:latest .'
            }
        }

        stage('Test Sintaxis (Fase 2)') {
            steps {
                sh 'python3 -m py_compile pichichi.py'
            }
        }

        stage('SonarQube Analysis (Fase 3)') {
            steps {
                script {
                    // Aquí cargamos la herramienta "scanner" que configuramos en Jenkins
                    def scannerHome = tool 'scanner'
                    withSonarQubeEnv('SonarQube') { 
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }
}
