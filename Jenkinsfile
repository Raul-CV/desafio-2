pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-west-2'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   stages {
        stage('Checkout') {
            steps {
                // Reemplaza con la URL de tu repositorio
                git 'https://github.com/Raul-CV/desafio-2.git'
            }
        }
        
        stage('Install dependencies') {
            steps {
                // Instalar dependencias si es necesario
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Package') {
            steps {
                // Crear un archivo ZIP de la función Lambda
                sh 'zip -r9 lambda_function.zip .'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Desplegar la función Lambda usando AWS CLI
                    sh '''
                    aws lambda update-function-code \
                        --function-name milambdafuncion \
                        --zip-file fileb://lambda_function.zip
                    '''
                }
            }
        }
    }
}