resource "aws_cognito_user_pool" "main" {
    name = "${var.project_name}-user-pool"

    password_policy {
        minimum_length    = 12
        require_lowercase = true
        require_numbers   = true
        require_symbols   = true
        require_uppercase = true
    }

    mfa_configuration ="ON"

    software_token_mfa_configuration {
        enabled = true
    }

    account_recovery_setting {
        recovery_mechanism {
            name     = "verified_email"
            priority = 1
        }
    }

    tags = {
        Name        = "${var.project_name}-user-pool"
        Environment = var.environment
    }
}

resource "aws_cognito_user_pool_client" "main" {
    name         = "${var.project_name}-client"
    user_pool_id = aws_cognito_user_pool.main.id

    explicit_auth_flows = [
        "ALLOW_USER_SRP_AUTH",
        "ALLOW_REFRESH_TOKEN_AUTH"
    ]

    access_token_validity  = 1
    id_token_validity      = 1
    refresh_token_validity = 30

    token_validity_units {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
    }

    prevent_user_existence_errors = "ENABLED"
}