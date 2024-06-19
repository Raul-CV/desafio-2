pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-west-2'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Package') {
            steps {
                script {
                    // Definir la lista de archivos que deseas incluir en el ZIP
                    def filesToZip = 'lambda_function.py' // Reemplaza con tus archivos

                    // Crear el archivo ZIP usando Python y zipfile
                    sh '''
                    python -c "import zipfile; with zipfile.ZipFile('lambda_function.zip', 'w') as zf: 
                    for f in '${filesToZip}'.split(): zf.write(f)"
                    '''
                }
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