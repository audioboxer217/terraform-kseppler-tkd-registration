# General Inputs
variable "aws_account_number" {
  type        = string
  description = "The AWS Account where the resources will be created (uses 'current' data source when not provided)."
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the resources will be created (uses 'current' data source when not provided)."
  default     = ""
}

variable "TFC_WORKSPACE_NAME" {
  type        = string
  description = "The name of the workspace in Terraform Cloud where this is managed."
  default     = ""
}

# Competition Details
variable "domain_name" {
  type        = string
  description = "The domain to use for this site."
}

variable "email_send_server" {
  type        = string
  description = "The email server to send emails from."
}

variable "email_send_port" {
  type        = string
  description = "The port for the email server to send emails from."
  default     = "465"
}

variable "email_send_address" {
  type        = string
  description = "The email address to use to send emails from."
}

variable "email_send_password" {
  type        = string
  sensitive   = true
  description = "The password for the 'email_send_address'."
}

variable "competition_name" {
  type        = string
  description = "The name of the competition."
}

variable "competition_year" {
  type        = string
  description = "The year of the competition."
}

variable "early_reg_date" {
  type        = string
  description = "The date when Early Registration closes."
}

variable "reg_close_date" {
  type        = string
  description = "The date when Final Registration closes."
}
variable "contact_email" {
  type        = string
  description = "The email to give to users as a contact."
}
variable "admin_email" {
  type        = string
  description = "The email to use for sending admin-related items."
}

variable "visitor_info_url" {
  type        = string
  description = "URL to use for the visitor information link."
  default     = ""
}

variable "visitor_info_text" {
  type        = string
  description = "Text to use for the visitor information link."
  default     = ""
}

variable "event_city" {
  type        = string
  description = "The city where the event is being held."
  default     = ""
}

# API Details
variable "flask_secret_key" {
  type        = string
  sensitive   = true
  description = "The secret key to use for Flask."
  default     = null
}
variable "maps_api_key" {
  type        = string
  sensitive   = true
  description = "The API Key for Google Maps."
}

variable "stripe_api_key" {
  type        = string
  sensitive   = true
  description = "The API Key for Stripe."
}

# AWS Resource Inputs
variable "processing_queue_name" {
  type        = string
  description = "The name to use for the 'processing' SQS Queue."
  default     = "processing"
}

variable "failed_registrations_queue_name" {
  type        = string
  description = "The name to use for the 'failed' SQS Queue."
  default     = "failed_registrations"
}

variable "registration_table_name" {
  type        = string
  description = "The name to use for 'registrations' DynamoDB Table."
}

variable "auth_table_name" {
  type        = string
  description = "The name to use for the 'auth' DynamoDB Table."
  default     = "admin_auth_table"
}

variable "lookup_table_name" {
  type        = string
  description = "The name to use for the 'lookup' DynamoDB Table."
  default     = "reg_lookup_table"
}

variable "profile_pics_bucket_name" {
  type        = string
  description = "The name to use for bucket that will hold the Profile Pics (Overrides `profile_pics_bucket_prefix` if provided)."
  default     = ""
}

variable "badges_bucket_name" {
  type        = string
  description = "The name to use for bucket that will hold the Badges (Overrides `badges_bucket_prefix` if provided)."
  default     = ""
}

variable "config_bucket_name" {
  type        = string
  description = "The name to use for bucket that will hold the Configs (Overrides `config_bucket_prefix` if provided)."
  default     = ""
}

variable "connect_account" {
  type        = string
  description = "The Connect Account ID from Stipe."
  default     = ""
}

variable "public_media_bucket_name" {
  type        = string
  description = "The name to use for bucket that will hold the public media (Overrides `public_media_bucket_prefix` if provided)."
  default     = ""
}

variable "profile_pics_bucket_prefix" {
  type        = string
  description = "The prefix to use for bucket that will hold the Profile Pics."
  default     = "tkd-reg-profile-pics"
}

variable "badges_bucket_prefix" {
  type        = string
  description = "The prefix to use for bucket that will hold the Badges."
  default     = "tkd-reg-badges"
}

variable "config_bucket_prefix" {
  type        = string
  description = "The prefix to use for bucket that will hold the Configs."
  default     = "tkd-reg-config"
}

variable "public_media_bucket_prefix" {
  type        = string
  description = "The prefix to use for bucket that will hold the public media."
  default     = "tkd-reg-public-media"
}

variable "admin_user_pool_name" {
  type        = string
  description = "value for the admin user pool name"
  default     = "TKD Reg Admins"
}

variable "admin_user_pool_domain_name" {
  type        = string
  description = "value for the admin user pool domain name"
  default     = null
}

variable "schools" {
  type        = list(string)
  description = "Listing of all school options"
  default = [
    "Earlywine Park YMCA",
    "Farfan's TKD",
    "Geomi",
    "Golden Dragon TKD - Midtown",
    "Golden Dragon TKD - Owasso",
    "Golden Dragon TKD - Tulsa",
    "Golden Tiger Martial Arts",
    "Grand Master Sean Kim's TKD",
    "Iron Horse TKD Academny",
    "Jeong's TKD Martial Arts",
    "Jido Kwon TKD",
    "Legacy Taekwondo",
    "Lee's Martial Arts Taekwondo Academy",
    "Master Hong's Olympic TKD",
    "Master Shin's Academy",
    "Master Yoo's World Champion Taekwondo",
    "MHCK World Class TKD",
    "Off The Chain",
    "Poos TKD",
    "Tiger Jung's TKD",
    "White Tiger TKD",
    "White Tiger TKD - Rockwall",
    "Yang's Martial Arts",
    "Young Moo Taekwondo"
  ]
}
