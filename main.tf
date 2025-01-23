resource "aws_sqs_queue" "processing_queue" {
  content_based_deduplication       = false
  deduplication_scope               = null
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = null
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = var.processing_queue_name
  name_prefix                       = null
  policy                            = data.aws_iam_policy_document.processing_sqs_policy.json
  receive_wait_time_seconds         = 0
  redrive_allow_policy              = null
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.failed_registrations_queue.arn
    maxReceiveCount     = 10
  })
  sqs_managed_sse_enabled    = true
  tags                       = local.common_tags
  visibility_timeout_seconds = 600
}

resource "aws_sqs_queue" "failed_registrations_queue" {
  content_based_deduplication       = false
  deduplication_scope               = null
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = null
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = var.failed_registrations_queue_name
  name_prefix                       = null
  policy                            = data.aws_iam_policy_document.failed_registrations_sqs_policy.json
  receive_wait_time_seconds         = 0
  redrive_allow_policy              = null
  redrive_policy                    = null
  sqs_managed_sse_enabled           = true
  tags                              = local.common_tags
  visibility_timeout_seconds        = 30
}

resource "aws_dynamodb_table" "registrations_table" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = false
  hash_key                    = "pk"
  name                        = var.registration_table_name
  range_key                   = null
  read_capacity               = 0
  restore_date_time           = null
  restore_source_name         = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = local.common_tags
  write_capacity              = 0
  attribute {
    name = "pk"
    type = "S"
  }
  attribute {
    name = "reg_type"
    type = "S"
  }
  global_secondary_index {
    hash_key           = "reg_type"
    name               = "reg_type-index"
    non_key_attributes = []
    projection_type    = "ALL"
    range_key          = null
    read_capacity      = 0
    write_capacity     = 0
  }
  point_in_time_recovery {
    enabled = true
  }
  ttl {
    attribute_name = ""
    enabled        = false
  }
}

resource "aws_dynamodb_table" "auth_table" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = false
  hash_key                    = "id"
  name                        = var.auth_table_name
  range_key                   = null
  read_capacity               = 0
  restore_date_time           = null
  restore_source_name         = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = local.common_tags
  write_capacity              = 0
  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "email"
    type = "S"
  }
  global_secondary_index {
    hash_key           = "email"
    name               = "email-index"
    non_key_attributes = []
    projection_type    = "ALL"
    range_key          = null
    read_capacity      = 0
    write_capacity     = 0
  }
  point_in_time_recovery {
    enabled = true
  }
  ttl {
    attribute_name = ""
    enabled        = false
  }
}

resource "aws_dynamodb_table" "lookup_table" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = false
  hash_key                    = "pk"
  name                        = var.lookup_table_name
  range_key                   = null
  read_capacity               = 0
  restore_date_time           = null
  restore_source_name         = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = local.common_tags
  write_capacity              = 0
  attribute {
    name = "pk"
    type = "S"
  }
  attribute {
    name = "email"
    type = "S"
  }
  global_secondary_index {
    hash_key           = "email"
    name               = "email-index"
    non_key_attributes = []
    projection_type    = "ALL"
    range_key          = null
    read_capacity      = 0
    write_capacity     = 0
  }
  point_in_time_recovery {
    enabled = true
  }
  ttl {
    attribute_name = ""
    enabled        = false
  }
}

resource "aws_s3_bucket" "profile-pics_bucket" {
  bucket              = var.profile_pics_bucket_name == "" ? null : var.profile_pics_bucket_name
  bucket_prefix       = var.profile_pics_bucket_name != "" ? null : var.profile_pics_bucket_prefix
  force_destroy       = null
  object_lock_enabled = false
  tags                = local.common_tags
}

resource "aws_s3_bucket_versioning" "profile-pics_bucket" {
  bucket = aws_s3_bucket.profile-pics_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "badges_bucket" {
  bucket              = var.badges_bucket_name == "" ? null : var.badges_bucket_name
  bucket_prefix       = var.badges_bucket_name != "" ? null : var.badges_bucket_prefix
  force_destroy       = null
  object_lock_enabled = false
  tags                = local.common_tags
}

resource "aws_s3_bucket_versioning" "badges_bucket" {
  bucket = aws_s3_bucket.badges_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "config_bucket" {
  bucket              = var.config_bucket_name == "" ? null : var.config_bucket_name
  bucket_prefix       = var.config_bucket_name != "" ? null : var.config_bucket_prefix
  force_destroy       = null
  object_lock_enabled = false
  tags                = local.common_tags
}

resource "aws_s3_bucket_versioning" "config_bucket" {
  bucket = aws_s3_bucket.config_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "backend_json" {
  bucket = aws_s3_bucket.config_bucket.id
  key    = "backend.json"
  content = jsonencode(tomap({
    EMAIL_SERVER       = var.email_send_server
    EMAIL_PORT         = var.email_send_port
    EMAIL_PASSWD       = var.email_send_password
    FROM_EMAIL         = var.email_send_address
    ADMIN_EMAIL        = var.admin_email
    STRIPE_API_KEY     = var.stripe_api_key
    COMPETITION_NAME   = var.competition_name
    COMPETITION_YEAR   = var.competition_year
    CONTACT_EMAIL      = var.contact_email
    PROFILE_PIC_BUCKET = aws_s3_bucket.profile-pics_bucket.id
    BADGE_BUCKET       = aws_s3_bucket.badges_bucket.id
    CONFIG_BUCKET      = aws_s3_bucket.config_bucket.id
    SQS_QUEUE_URL      = aws_sqs_queue.processing_queue.url
    DB_TABLE           = var.registration_table_name
  }))
  content_type           = "application/json"
  server_side_encryption = "AES256"
  storage_class          = "STANDARD"
  tags                   = local.common_tags
}

resource "aws_s3_object" "frontend_json" {
  bucket = aws_s3_bucket.config_bucket.id
  key    = "frontend.json"
  content = jsonencode(tomap({
    FLASK_SECRET_KEY      = var.flask_secret_key
    MAPS_API_KEY          = var.maps_api_key
    STRIPE_API_KEY        = var.stripe_api_key
    REG_URL               = "https://${var.domain_name}"
    COMPETITION_NAME      = var.competition_name
    COMPETITION_YEAR      = var.competition_year
    EARLY_REG_DATE        = var.early_reg_date
    REG_CLOSE_DATE        = var.reg_close_date
    CONTACT_EMAIL         = var.contact_email
    PROFILE_PIC_BUCKET    = aws_s3_bucket.profile-pics_bucket.id
    CONFIG_BUCKET         = aws_s3_bucket.config_bucket.id
    PUBLIC_MEDIA_BUCKET   = aws_s3_bucket.public_media_bucket.id
    SQS_QUEUE_URL         = aws_sqs_queue.processing_queue.url
    REG_DB_TABLE          = var.registration_table_name
    AUTH_DB_TABLE         = var.auth_table_name
    CONNECT_ACCT          = var.connect_account
    VISITOR_INFO_URL      = var.visitor_info_url
    VISITOR_INFO_TEXT     = var.visitor_info_text
    EVENT_CITY            = var.event_city
    COGNITO_AUTHORITY_URL = aws_cognito_user_pool.admin_users.endpoint
    COGNITO_CLIENT_ID     = aws_cognito_user_pool_client.client.id
    COGNITO_CLIENT_SECRET = aws_cognito_user_pool_client.client.client_secret
    COGNITO_AUTH_URL      = "https://${local.cognito_domain}.auth.${local.aws_region}.amazoncognito.com"
  }))
  content_type           = "application/json"
  server_side_encryption = "AES256"
  storage_class          = "STANDARD"
  tags                   = local.common_tags
}

resource "aws_s3_object" "schools_json" {
  bucket                 = aws_s3_bucket.config_bucket.id
  key                    = "schools.json"
  content                = jsonencode(var.schools)
  content_type           = "application/json"
  server_side_encryption = "AES256"
  storage_class          = "STANDARD"
  tags                   = local.common_tags
}

resource "aws_s3_bucket" "public_media_bucket" {
  bucket              = var.public_media_bucket_name == "" ? null : var.public_media_bucket_name
  bucket_prefix       = var.public_media_bucket_name != "" ? null : var.public_media_bucket_prefix
  force_destroy       = null
  object_lock_enabled = false
  tags                = local.common_tags
}

resource "aws_s3_bucket_versioning" "public_media_bucket" {
  bucket = aws_s3_bucket.public_media_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = local.common_tags
}

resource "aws_acm_certificate" "main" {
  domain_name               = var.domain_name
  key_algorithm             = "RSA_2048"
  subject_alternative_names = [var.domain_name]
  validation_method         = "DNS"
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
  tags = local.common_tags
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}

resource "aws_cognito_user_pool" "admin_users" {
  name                     = var.admin_user_pool_name
  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]
  deletion_protection      = "ACTIVE"
  tags                     = local.common_tags
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }
  admin_create_user_config {
    allow_admin_create_user_only = false
  }
  email_configuration {
    configuration_set      = null
    email_sending_account  = "COGNITO_DEFAULT"
    from_email_address     = null
    reply_to_email_address = null
    source_arn             = null
  }
  password_policy {
    minimum_length                   = 8
    password_history_size            = 0
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true
    string_attribute_constraints {
      max_length = jsonencode(2048)
      min_length = jsonencode(0)
    }
  }
  username_configuration {
    case_sensitive = false
  }
  verification_message_template {
    default_email_option  = "CONFIRM_WITH_CODE"
    email_message         = null
    email_message_by_link = null
    email_subject         = null
    email_subject_by_link = null
    sms_message           = null
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = local.cognito_domain
  user_pool_id = aws_cognito_user_pool.admin_users.id
}

resource "aws_cognito_user_pool_client" "client" {
  name                                          = var.admin_user_pool_name
  user_pool_id                                  = aws_cognito_user_pool.admin_users.id
  access_token_validity                         = 60
  allowed_oauth_flows                           = ["code"]
  allowed_oauth_flows_user_pool_client          = true
  allowed_oauth_scopes                          = ["email", "openid", "phone"]
  auth_session_validity                         = 3
  callback_urls                                 = ["http://localhost:5001/authorize", "https://${var.domain_name}/authorize"]
  enable_propagate_additional_user_context_data = false
  enable_token_revocation                       = true
  explicit_auth_flows                           = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
  generate_secret                               = true
  id_token_validity                             = 60
  logout_urls                                   = ["http://localhost:5001/", "https://${var.domain_name}/"]
  prevent_user_existence_errors                 = "ENABLED"
  read_attributes                               = []
  refresh_token_validity                        = 5
  supported_identity_providers                  = ["COGNITO"]
  write_attributes                              = []
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}
