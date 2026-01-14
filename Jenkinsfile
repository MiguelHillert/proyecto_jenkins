pipeline {
    agent any 
    stages {
        stage('Checkout') {
            steps { checkout scm }
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
                withSonarQubeEnv('SonarQube') { 
                    sh 'sonar-scanner'
                }
            }
        }
    }
}
