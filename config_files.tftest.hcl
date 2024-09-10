variables {
  config_bucket_prefix    = "test-config"
  registration_table_name = "test_reg_table"
  domain_name             = "test.reg.com"
  email_send_server       = "smtp.gmail.com"
  email_send_port         = "465"
  email_send_address      = "test@gmail.com"
  email_send_password     = "p@ss1234"
  competition_name        = "Test TKD"
  competition_year        = "2000"
  early_reg_date          = "January 10, 2000"
  reg_close_date          = "February 10, 2000"
  contact_email           = "test@gmail.com"
  admin_email             = "admin@gmail.com"
  visitor_info_url        = "visitCITY.com"
  visitor_info_text       = "Things to do in CITY"
  maps_api_key            = "m@psK3y"
  stripe_api_key          = "$trip3ky"
}
run "validate_config_files" {
  command = apply

  plan_options {
    target = [
      aws_s3_bucket.config_bucket,
      aws_s3_object.frontend_json,
      aws_s3_object.backend_json
    ]
  }

  assert {
    condition     = aws_s3_object.frontend_json.content != ""
    error_message = "Frontend Config is empty!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).MAPS_API_KEY == "m@psK3y"
    error_message = "MAPS_API_KEY not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).STRIPE_API_KEY == "$trip3ky"
    error_message = "STRIPE_API_KEY not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).REG_URL == "https://test.reg.com"
    error_message = "REG_URL not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).COMPETITION_NAME == "Test TKD"
    error_message = "COMPETITION_NAME not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).COMPETITION_YEAR == "2000"
    error_message = "COMPETITION_YEAR not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).EARLY_REG_DATE == "January 10, 2000"
    error_message = "EARLY_REG_DATE not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).REG_CLOSE_DATE == "February 10, 2000"
    error_message = "REG_CLOSE_DATE not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).CONTACT_EMAIL == "test@gmail.com"
    error_message = "CONTACT_EMAIL not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).VISITOR_INFO_URL == "visitCITY.com"
    error_message = "VISITOR_INFO_URL not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.frontend_json.content).VISITOR_INFO_TEXT == "Things to do in CITY"
    error_message = "VISITOR_INFO_TEXT not set in Frontend Config as expected!"
  }

  assert {
    condition     = aws_s3_object.backend_json.content != ""
    error_message = "Backend Config is empty!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).EMAIL_SERVER == "smtp.gmail.com"
    error_message = "EMAIL_SERVER not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).EMAIL_PORT == "465"
    error_message = "EMAIL_PORT not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).EMAIL_PASSWD == "p@ss1234"
    error_message = "EMAIL_PASSWD not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).FROM_EMAIL == "test@gmail.com"
    error_message = "FROM_EMAIL not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).ADMIN_EMAIL == "admin@gmail.com"
    error_message = "ADMIN_EMAIL not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).STRIPE_API_KEY == "$trip3ky"
    error_message = "STRIPE_API_KEY not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).COMPETITION_NAME == "Test TKD"
    error_message = "COMPETITION_NAME not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).COMPETITION_YEAR == "2000"
    error_message = "COMPETITION_YEAR not set in Frontend Config as expected!"
  }

  assert {
    condition     = jsondecode(aws_s3_object.backend_json.content).CONTACT_EMAIL == "test@gmail.com"
    error_message = "CONTACT_EMAIL not set in Frontend Config as expected!"
  }
}