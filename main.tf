provider "aws" {
  region = "eu-west-2"  # Cambia esto según tu región AWS
}

# Crea un archivo zip con tu función Lambda y sus dependencias
resource "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function/lambda.py"
  output_path = "${path.module}/lambda_function/lambda.zip"
}

# Crea la función Lambda en AWS
resource "aws_lambda_function" "my_lambda_function" {
  filename      = "${path.module}/lambda_function/lambda.zip"
  function_name = "myLambdaFunctions"  # Cambia el nombre según tu preferencia
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda.handler"
  runtime       = "python3.8"  # Ajusta según la versión de Python que estés utilizando

  environment {
    variables = {
      ENV_VAR_NAME = "value"  # Puedes añadir variables de entorno aquí si es necesario
    }
  }
}

# Define el rol IAM para ejecutar la función Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"  # Nombre del rol
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# Asocia una política IAM básica para ejecutar funciones Lambda
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}

# Outputs (opcional)
output "lambda_function_name" {
  value = aws_lambda_function.my_lambda_function.function_name
  description = "Nombre de la función Lambda creada"
}
