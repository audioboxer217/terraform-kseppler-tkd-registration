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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.23.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.registrations_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_s3_bucket.badges_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.config_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.profile-pics_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.public_media_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.allow_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.public_media_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_sqs_queue.failed_registrations_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.processing_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.allow_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.failed_registrations_sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.processing_sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_number"></a> [aws\_account\_number](#input\_aws\_account\_number) | The AWS Account where the resources will be created (uses 'current' data source when not provided). | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the resources will be created (uses 'current' data source when not provided). | `string` | `""` | no |
| <a name="input_badges_bucket_name"></a> [badges\_bucket\_name](#input\_badges\_bucket\_name) | The name to use for bucket that will hold the Badges (Overrides `badges_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_badges_bucket_prefix"></a> [badges\_bucket\_prefix](#input\_badges\_bucket\_prefix) | The prefix to use for bucket that will hold the Badges. | `string` | `"tkd-reg-badges"` | no |
| <a name="input_config_bucket_name"></a> [config\_bucket\_name](#input\_config\_bucket\_name) | The name to use for bucket that will hold the Configs (Overrides `config_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_config_bucket_prefix"></a> [config\_bucket\_prefix](#input\_config\_bucket\_prefix) | The prefix to use for bucket that will hold the Configs. | `string` | `"tkd-reg-config"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain to use for this site. | `string` | n/a | yes |
| <a name="input_failed_registrations_queue_name"></a> [failed\_registrations\_queue\_name](#input\_failed\_registrations\_queue\_name) | The name to use for the 'failed' SQS Queue. | `string` | `"failed_registrations"` | no |
| <a name="input_processing_queue_name"></a> [processing\_queue\_name](#input\_processing\_queue\_name) | The name to use for the 'processing' SQS Queue. | `string` | `"processing"` | no |
| <a name="input_profile_pics_bucket_name"></a> [profile\_pics\_bucket\_name](#input\_profile\_pics\_bucket\_name) | The name to use for bucket that will hold the Profile Pics (Overrides `profile_pics_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_profile_pics_bucket_prefix"></a> [profile\_pics\_bucket\_prefix](#input\_profile\_pics\_bucket\_prefix) | The prefix to use for bucket that will hold the Profile Pics. | `string` | `"tkd-reg-profile-pics"` | no |
| <a name="input_public_media_bucket_name"></a> [public\_media\_bucket\_name](#input\_public\_media\_bucket\_name) | The name to use for bucket that will hold the public media (Overrides `public_media_bucket_prefix` if provided). | `string` | `""` | no |
| <a name="input_public_media_bucket_prefix"></a> [public\_media\_bucket\_prefix](#input\_public\_media\_bucket\_prefix) | The prefix to use for bucket that will hold the public media. | `string` | `"tkd-reg-public-media"` | no |
| <a name="input_registration_table_name"></a> [registration\_table\_name](#input\_registration\_table\_name) | The name to use for 'registrations' DynamoDB Table. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_badges_bucket_name"></a> [badges\_bucket\_name](#output\_badges\_bucket\_name) | The name of the Badges S3 Bucket. |
| <a name="output_config_bucket_name"></a> [config\_bucket\_name](#output\_config\_bucket\_name) | The name of the Config S3 Bucket. |
| <a name="output_domain_name_servers"></a> [domain\_name\_servers](#output\_domain\_name\_servers) | The list of name servers for the domain. |
| <a name="output_domain_zone_id"></a> [domain\_zone\_id](#output\_domain\_zone\_id) | The Zone ID for the domain |
| <a name="output_processing_queue_url"></a> [processing\_queue\_url](#output\_processing\_queue\_url) | The URL for the Processing SQS Queue. |
| <a name="output_profile_pics_bucket_name"></a> [profile\_pics\_bucket\_name](#output\_profile\_pics\_bucket\_name) | The name of the Profile Pics S3 Bucket. |
| <a name="output_public_media_bucket_name"></a> [public\_media\_bucket\_name](#output\_public\_media\_bucket\_name) | The name of the Public Media S3 Bucket. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
