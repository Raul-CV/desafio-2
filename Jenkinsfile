pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-west-2'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages {
        // stage('Checkout') {
        //     steps {
        //         checkout scm
        //     }
        // }

        stage('Deploy Lambda Function') {
            steps {
                script {
                    sh '''
                        # Define el nombre de tu función Lambda y el archivo .py
                        LAMBDA_FUNCTION_NAME="milambdafuncion"
                        LAMBDA_HANDLER="lambda_function.lambda_handler"
                        LAMBDA_RUNTIME="python3.11"

                        # Lee el código del archivo Python
                        LAMBDA_CODE="$(< lambda_function.py)"

                        # Crea o actualiza la función Lambda
                        aws lambda create-function \
                            --function-name $LAMBDA_FUNCTION_NAME \
                            --handler $LAMBDA_HANDLER \
                            --runtime $LAMBDA_RUNTIME \
                            --role arn:aws:iam::767398072756:role/aws-rol-lambda \
                            --code "InlineCode=$LAMBDA_CODE"
                    '''
                }
            }
        }
    }
}