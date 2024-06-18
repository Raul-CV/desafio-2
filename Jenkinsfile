pipeline {
    agent any

    environment {
        // AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_REGION = 'eu-west-2'  // Cambia esto por tu región
    }

    stages {
        // stage('Checkout') {
        //     steps {
        //         // Reemplaza 'repo-url' con la URL de tu repositorio
        //         git 'repo-url'
        //     }
        // }

        stage('Install dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt -t package'
            }
        }

        stage('Package Lambda') {
            steps {
                sh '''
                cd package
                zip -r9 ../function.zip .
                cd ..
                zip -g function.zip lambda_function.py
                '''
            }
        }

        stage('Deploy Lambda') {
            steps {
                withAWS(region: "${env.AWS_REGION}", credentials: 'aws-credentials-id') {
                    sh '''
                    aws lambda update-function-code \
                    --function-name milambdafuncion \
                    --zip-file fileb://function.zip
                    '''
                }
            }
        }
    }
}