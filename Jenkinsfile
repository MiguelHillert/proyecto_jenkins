pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        
        stage('Construir Docker (Fase 1)') {
            steps {
                // Construimos la imagen
                sh 'docker build -t pichichi:latest .'
            }
        }

        stage('Despliegue de Prueba ') {
            steps {
                script {
                    try {
                        
                        sh 'docker run -d --name test_pichichi pichichi:latest'
                        
                        
                        sh 'sleep 5'
                        
                       
                        sh 'docker logs test_pichichi'
                        echo '¡El contenedor ha arrancado y muestra el menú correctamente!'
                    } finally {
                        
                        sh 'docker rm -f test_pichichi'
                    }
                }
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
                    def scannerHome = tool 'scanner'
                    withSonarQubeEnv('SonarQube') { 
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
    }
}
