output "processing_queue_url" {
  description = "The URL for the Processing SQS Queue."
  value       = aws_sqs_queue.processing_queue.url
}

output "config_bucket_name" {
  description = "The name of the Config S3 Bucket."
  value       = aws_s3_bucket.config_bucket.id
}

output "profile_pics_bucket_name" {
  description = "The name of the Profile Pics S3 Bucket."
  value       = aws_s3_bucket.profile-pics_bucket.id
}

output "badges_bucket_name" {
  description = "The name of the Badges S3 Bucket."
  value       = aws_s3_bucket.badges_bucket.id
}
