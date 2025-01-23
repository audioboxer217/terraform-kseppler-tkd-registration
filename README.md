# TKD Registration Infrastructure Module
This repo contains a module to standup the basic infrastructure used for the [gdtkd_competition_registration](https://github.com/audioboxer217/gdtkd_registration) repository.

## Terraform Details
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cognito_user_group.admins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_group) | resource |
| [aws_cognito_user_pool.admin_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |
| [aws_dynamodb_table.auth_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.lookup_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.registrations_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_s3_bucket.badges_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.config_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.profile-pics_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.public_media_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_versioning.badges_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.config_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.profile-pics_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.public_media_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.backend_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.frontend_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.schools_json](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_sqs_queue.failed_registrations_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.processing_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.failed_registrations_sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.processing_sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_TFC_WORKSPACE_NAME"></a> [TFC\_WORKSPACE\_NAME](#input\_TFC\_WORKSPACE\_NAME) | The name of the workspace in Terraform Cloud where this is managed. | `string` | `""` | no |
| <a name="input_admin_email"></a> [admin\_email](#input\_admin\_email) | The email to use for sending admin-related items. | `string` | n/a | yes |
| <a name="input_admin_user_pool_domain_name"></a> [admin\_user\_pool\_domain\_name](#input\_admin\_user\_pool\_domain\_name) | value for the admin user pool domain name | `string` | `null` | no |
| <a name="input_admin_user_pool_name"></a> [admin\_user\_pool\_name](#input\_admin\_user\_pool\_name) | value for the admin user pool name | `string` | `"TKD Reg Admins"` | no |
| <a name="input_auth_table_name"></a> [auth\_table\_name](#input\_auth\_table\_name) | The name to use for the 'auth' DynamoDB Table. | `string` | `"admin_auth_table"` | no |
| <a name="input_aws_account_number"></a> [aws\_account\_number](#input\_aws\_account\_number) | The AWS Account where the resources will be created (uses 'current' data source when not provided). | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the resources will be created (uses 'current' data source when not provided). | `string` | `""` | no |
| <a name="input_badges_bucket_name"></a> [badges\_bucket\_name](#input\_badges\_bucket\_name) | The name to use for bucket that will hold the Badges (Overrides `badges_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_badges_bucket_prefix"></a> [badges\_bucket\_prefix](#input\_badges\_bucket\_prefix) | The prefix to use for bucket that will hold the Badges. | `string` | `"tkd-reg-badges"` | no |
| <a name="input_competition_name"></a> [competition\_name](#input\_competition\_name) | The name of the competition. | `string` | n/a | yes |
| <a name="input_competition_year"></a> [competition\_year](#input\_competition\_year) | The year of the competition. | `string` | n/a | yes |
| <a name="input_config_bucket_name"></a> [config\_bucket\_name](#input\_config\_bucket\_name) | The name to use for bucket that will hold the Configs (Overrides `config_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_config_bucket_prefix"></a> [config\_bucket\_prefix](#input\_config\_bucket\_prefix) | The prefix to use for bucket that will hold the Configs. | `string` | `"tkd-reg-config"` | no |
| <a name="input_connect_account"></a> [connect\_account](#input\_connect\_account) | The Connect Account ID from Stipe. | `string` | `""` | no |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | The email to give to users as a contact. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain to use for this site. | `string` | n/a | yes |
| <a name="input_early_reg_date"></a> [early\_reg\_date](#input\_early\_reg\_date) | The date when Early Registration closes. | `string` | n/a | yes |
| <a name="input_email_send_address"></a> [email\_send\_address](#input\_email\_send\_address) | The email address to use to send emails from. | `string` | n/a | yes |
| <a name="input_email_send_password"></a> [email\_send\_password](#input\_email\_send\_password) | The password for the 'email\_send\_address'. | `string` | n/a | yes |
| <a name="input_email_send_port"></a> [email\_send\_port](#input\_email\_send\_port) | The port for the email server to send emails from. | `string` | `"465"` | no |
| <a name="input_email_send_server"></a> [email\_send\_server](#input\_email\_send\_server) | The email server to send emails from. | `string` | n/a | yes |
| <a name="input_event_city"></a> [event\_city](#input\_event\_city) | The city where the event is being held. | `string` | `""` | no |
| <a name="input_failed_registrations_queue_name"></a> [failed\_registrations\_queue\_name](#input\_failed\_registrations\_queue\_name) | The name to use for the 'failed' SQS Queue. | `string` | `"failed_registrations"` | no |
| <a name="input_flask_secret_key"></a> [flask\_secret\_key](#input\_flask\_secret\_key) | The secret key to use for Flask. | `string` | `null` | no |
| <a name="input_lookup_table_name"></a> [lookup\_table\_name](#input\_lookup\_table\_name) | The name to use for the 'lookup' DynamoDB Table. | `string` | `"reg_lookup_table"` | no |
| <a name="input_maps_api_key"></a> [maps\_api\_key](#input\_maps\_api\_key) | The API Key for Google Maps. | `string` | n/a | yes |
| <a name="input_processing_queue_name"></a> [processing\_queue\_name](#input\_processing\_queue\_name) | The name to use for the 'processing' SQS Queue. | `string` | `"processing"` | no |
| <a name="input_profile_pics_bucket_name"></a> [profile\_pics\_bucket\_name](#input\_profile\_pics\_bucket\_name) | The name to use for bucket that will hold the Profile Pics (Overrides `profile_pics_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_profile_pics_bucket_prefix"></a> [profile\_pics\_bucket\_prefix](#input\_profile\_pics\_bucket\_prefix) | The prefix to use for bucket that will hold the Profile Pics. | `string` | `"tkd-reg-profile-pics"` | no |
| <a name="input_public_media_bucket_name"></a> [public\_media\_bucket\_name](#input\_public\_media\_bucket\_name) | The name to use for bucket that will hold the public media (Overrides `public_media_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_public_media_bucket_prefix"></a> [public\_media\_bucket\_prefix](#input\_public\_media\_bucket\_prefix) | The prefix to use for bucket that will hold the public media. | `string` | `"tkd-reg-public-media"` | no |
| <a name="input_reg_close_date"></a> [reg\_close\_date](#input\_reg\_close\_date) | The date when Final Registration closes. | `string` | n/a | yes |
| <a name="input_registration_table_name"></a> [registration\_table\_name](#input\_registration\_table\_name) | The name to use for 'registrations' DynamoDB Table. | `string` | n/a | yes |
| <a name="input_schools"></a> [schools](#input\_schools) | Listing of all school options | `list(string)` | <pre>[<br/>  "Earlywine Park YMCA",<br/>  "Farfan's TKD",<br/>  "Geomi",<br/>  "Golden Dragon TKD - Midtown",<br/>  "Golden Dragon TKD - Owasso",<br/>  "Golden Dragon TKD - Tulsa",<br/>  "Golden Tiger Martial Arts",<br/>  "Grand Master Sean Kim's TKD",<br/>  "Iron Horse TKD Academny",<br/>  "Jeong's TKD Martial Arts",<br/>  "Jido Kwon TKD",<br/>  "Legacy Taekwondo",<br/>  "Lee's Martial Arts Taekwondo Academy",<br/>  "Master Hong's Olympic TKD",<br/>  "Master Shin's Academy",<br/>  "Master Yoo's World Champion Taekwondo",<br/>  "MHCK World Class TKD",<br/>  "Off The Chain",<br/>  "Poos TKD",<br/>  "Tiger Jung's TKD",<br/>  "White Tiger TKD",<br/>  "White Tiger TKD - Rockwall",<br/>  "Yang's Martial Arts",<br/>  "Young Moo Taekwondo"<br/>]</pre> | no |
| <a name="input_stripe_api_key"></a> [stripe\_api\_key](#input\_stripe\_api\_key) | The API Key for Stripe. | `string` | n/a | yes |
| <a name="input_visitor_info_text"></a> [visitor\_info\_text](#input\_visitor\_info\_text) | Text to use for the visitor information link. | `string` | `""` | no |
| <a name="input_visitor_info_url"></a> [visitor\_info\_url](#input\_visitor\_info\_url) | URL to use for the visitor information link. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_badges_bucket_name"></a> [badges\_bucket\_name](#output\_badges\_bucket\_name) | The name of the Badges S3 Bucket. |
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | The ARN for the ACM Cert |
| <a name="output_config_bucket_name"></a> [config\_bucket\_name](#output\_config\_bucket\_name) | The name of the Config S3 Bucket. |
| <a name="output_domain_name_servers"></a> [domain\_name\_servers](#output\_domain\_name\_servers) | The list of name servers for the domain. |
| <a name="output_domain_zone_id"></a> [domain\_zone\_id](#output\_domain\_zone\_id) | The Zone ID for the domain |
| <a name="output_processing_queue_url"></a> [processing\_queue\_url](#output\_processing\_queue\_url) | The URL for the Processing SQS Queue. |
| <a name="output_profile_pics_bucket_name"></a> [profile\_pics\_bucket\_name](#output\_profile\_pics\_bucket\_name) | The name of the Profile Pics S3 Bucket. |
| <a name="output_public_media_bucket_name"></a> [public\_media\_bucket\_name](#output\_public\_media\_bucket\_name) | The name of the Public Media S3 Bucket. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
