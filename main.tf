locals {
  resource_prefix = "KY-tf"
}

resource "aws_dynamodb_table" "bookinventory" {
  name         = "${local.resource_prefix}-bookinventory"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = var.hash_key
  range_key = var.sort_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  attribute {
    name = var.sort_key
    type = "S"
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${local.resource_prefix}-dynamodb-read"
  path        = "/"
  description = "Policy for listing and writing"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:BatchGetItem",
          "dynamodb:DescribeImport",
          "dynamodb:ConditionCheckItem",
          "dynamodb:DescribeContributorInsights",
          "dynamodb:Scan",
          "dynamodb:ListTagsOfResource",
          "dynamodb:Query",
          "dynamodb:DescribeStream",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:DescribeGlobalTableSettings",
          "dynamodb:PartiQLSelect",
          "dynamodb:DescribeTable",
          "dynamodb:GetShardIterator",
          "dynamodb:DescribeGlobalTable",
          "dynamodb:GetItem",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeExport",
          "dynamodb:GetResourcePolicy",
          "dynamodb:DescribeKinesisStreamingDestination",
          "dynamodb:DescribeBackup",
          "dynamodb:GetRecords",
          "dynamodb:DescribeTableReplicaAutoScaling"
        ]
        Resource = aws_dynamodb_table.bookinventory.arn
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:ListContributorInsights",
          "dynamodb:DescribeReservedCapacityOfferings",
          "dynamodb:ListGlobalTables",
          "dynamodb:ListTables",
          "dynamodb:DescribeReservedCapacity",
          "dynamodb:ListBackups",
          "dynamodb:GetAbacStatus",
          "dynamodb:ListImports",
          "dynamodb:DescribeLimits",
          "dynamodb:DescribeEndpoints",
          "dynamodb:ListExports",
          "dynamodb:ListStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "read_role" {
  name = "${local.resource_prefix}-dynamodb-read-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_role_policy_attachment" "read-attach" {
  role       = aws_iam_role.read_role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "read_profile" {
  name = "${local.resource_prefix}-dynamodb-read-role"
  role = aws_iam_role.read_role.name
}




