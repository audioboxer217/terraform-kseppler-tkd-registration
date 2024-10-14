data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "processing_sqs_policy" {
  policy_id = "__default_policy_ID"

  statement {
    sid = "__owner_statement"

    actions = [
      "SQS:*",
    ]

    resources = [
      "arn:aws:sqs:${local.aws_region}:${local.aws_account_number}:${var.processing_queue_name}",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.aws_account_number}:root"]
    }
  }
}

data "aws_iam_policy_document" "failed_registrations_sqs_policy" {
  policy_id = "__default_policy_ID"

  statement {
    sid = "__owner_statement"

    actions = [
      "SQS:*",
    ]

    resources = [
      "arn:aws:sqs:${local.aws_region}:${local.aws_account_number}:${var.failed_registrations_queue_name}",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.aws_account_number}:root"]
    }
  }
}
