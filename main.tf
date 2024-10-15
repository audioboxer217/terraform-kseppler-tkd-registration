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
  tags                       = {}
  tags_all                   = {}
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
  tags                              = {}
  tags_all                          = {}
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
  tags                        = {}
  tags_all                    = {}
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
    enabled = false
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
  tags                = {}
  tags_all            = {}
}

resource "aws_s3_bucket" "badges_bucket" {
  bucket              = var.badges_bucket_name == "" ? null : var.badges_bucket_name
  bucket_prefix       = var.badges_bucket_name != "" ? null : var.badges_bucket_prefix
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}

resource "aws_s3_bucket" "config_bucket" {
  bucket              = var.config_bucket_name == "" ? null : var.config_bucket_name
  bucket_prefix       = var.config_bucket_name != "" ? null : var.config_bucket_prefix
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}

resource "aws_s3_bucket" "public_media_bucket" {
  bucket              = var.public_media_bucket_name == "" ? null : var.public_media_bucket_name
  bucket_prefix       = var.public_media_bucket_name != "" ? null : var.public_media_bucket_prefix
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}

resource "aws_s3_bucket_public_access_block" "public_media_bucket" {
  bucket = aws_s3_bucket.public_media_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.public_media_bucket.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}
