resource "aws_secretsmanager_secret" "mongodb_credentials_metadata" {
  name = "mongodb_credentials"
}

resource "aws_secretsmanager_secret_version" "mongodb_credentials" {
  secret_id = aws_secretsmanager_secret.mongodb_credentials_metadata.id
  secret_string = jsonencode({
    "this_is_a_secret_key" : "this_is_a_secret_value"
  })
}