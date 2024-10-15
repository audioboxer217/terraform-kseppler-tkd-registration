variables {
  registration_table_name         = "test_reg_table"
  domain_name                     = "test.reg.com"
  processing_queue_name           = "test_processing"
  failed_registrations_queue_name = "test_failed_registrations"
  TFC_WORKSPACE_NAME              = "test"
  email_send_server               = "smtp.gmail.com"
  email_send_port                 = "465"
  email_send_address              = "test@gmail.com"
  email_send_password             = "p@ss1234"
  competition_name                = "Test TKD"
  competition_year                = "2000"
  early_reg_date                  = "January 10, 2000"
  reg_close_date                  = "February 10, 2000"
  contact_email                   = "test@gmail.com"
  admin_email                     = "admin@gmail.com"
  visitor_info_url                = "visitCITY.com"
  visitor_info_text               = "Things to do in CITY"
  maps_api_key                    = "m@psK3y"
  stripe_api_key                  = "$trip3ky"
}

run "validate_route53" {
  command = plan

  assert {
    condition     = aws_route53_zone.main.name == "test.reg.com"
    error_message = "Route53 Domain name did not match expected"
  }
}

run "validate_dynamodb" {
  command = plan

  assert {
    condition     = aws_dynamodb_table.registrations_table.name == "test_reg_table"
    error_message = "DynamoDB Table name did not match expected"
  }
}

run "validate_default_buckets" {
  command = apply

  plan_options {
    target = [
      aws_s3_bucket.profile-pics_bucket,
      aws_s3_bucket.badges_bucket,
      aws_s3_bucket.config_bucket
    ]
  }

  assert {
    condition     = startswith(aws_s3_bucket.profile-pics_bucket.bucket, "tkd-reg-profile-pics")
    error_message = "Profile Pics bucket name did not match expected"
  }

  assert {
    condition     = startswith(aws_s3_bucket.badges_bucket.bucket, "tkd-reg-badges")
    error_message = "Badges bucket name did not match expected"
  }

  assert {
    condition     = startswith(aws_s3_bucket.config_bucket.bucket, "tkd-reg-config")
    error_message = "Config bucket name did not match expected"
  }
}

run "validate_custom_prefix_buckets" {
  command = apply

  variables {
    profile_pics_bucket_prefix = "test-profile-pics"
    badges_bucket_prefix       = "test-badges"
    config_bucket_prefix       = "test-config"
  }

  plan_options {
    target = [
      aws_s3_bucket.profile-pics_bucket,
      aws_s3_bucket.badges_bucket,
      aws_s3_bucket.config_bucket
    ]
  }

  assert {
    condition     = startswith(aws_s3_bucket.profile-pics_bucket.bucket, "test-profile-pics")
    error_message = "Profile Pics bucket name did not match expected"
  }

  assert {
    condition     = startswith(aws_s3_bucket.badges_bucket.bucket, "test-badges")
    error_message = "Badges bucket name did not match expected"
  }

  assert {
    condition     = startswith(aws_s3_bucket.config_bucket.bucket, "test-config")
    error_message = "Config bucket name did not match expected"
  }
}

run "validate_custom_name_buckets" {
  command = apply

  variables {
    profile_pics_bucket_prefix = "test-profile-pics"
    badges_bucket_prefix       = "test-badges"
    config_bucket_prefix       = "test-config"
    profile_pics_bucket_name   = "tkdreg-test-profile-pics-bucket"
    badges_bucket_name         = "tkdreg-test-badges-bucket"
    config_bucket_name         = "tkdreg-test-config-bucket"
  }

  plan_options {
    target = [
      aws_s3_bucket.profile-pics_bucket,
      aws_s3_bucket.badges_bucket,
      aws_s3_bucket.config_bucket
    ]
  }

  assert {
    condition     = aws_s3_bucket.profile-pics_bucket.bucket == "tkdreg-test-profile-pics-bucket"
    error_message = "Profile Pics bucket name did not match expected"
  }

  assert {
    condition     = aws_s3_bucket.badges_bucket.bucket == "tkdreg-test-badges-bucket"
    error_message = "Badges bucket name did not match expected"
  }

  assert {
    condition     = aws_s3_bucket.config_bucket.bucket == "tkdreg-test-config-bucket"
    error_message = "Config bucket name did not match expected"
  }
}

run "validate_sqs_queues" {
  command = apply

  plan_options {
    target = [
      aws_sqs_queue.processing_queue,
      aws_sqs_queue.failed_registrations_queue
    ]
  }

  assert {
    condition     = aws_sqs_queue.processing_queue.name == "test_processing"
    error_message = "SQS Processing Queue name did not match expected"
  }

  assert {
    condition     = aws_sqs_queue.failed_registrations_queue.name == "test_failed_registrations"
    error_message = "SQS Failed Queue name did not match expected"
  }
}
