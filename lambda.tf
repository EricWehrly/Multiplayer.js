variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region          = "${var.aws_region}"
}

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "index.js"
    output_path   = "lambda_function.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function.zip" # reference above?
  function_name    = "Multiplayer.js"
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "nodejs6.10"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
