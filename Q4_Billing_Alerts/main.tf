# NOTE: Set the variable 'prefix' to your FirstName_Lastname before applying, e.g. -var='prefix=Ayush_Yadav'
# You will also likely need to set 'ssh_key_name' to an existing keypair in your AWS account and update 'ami_id' for your region.
# WARNING: Billing resources and budgets are account-level. Ensure IAM permissions and region is us-east-1 for billing metrics.
provider "aws" {
  region = "us-east-1"
}

variable "prefix" { type=string; default="FirstName_Lastname" }

# CloudWatch billing alarm - estimates charges metric
resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name                = "${var.prefix}_billing_alarm_100INR"
  alarm_description         = "Alert when estimated charges exceed 100 INR (approx)"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "EstimatedCharges"
  namespace                 = "AWS/Billing"
  statistic                 = "Maximum"
  threshold                 = 2    # NOTE: Set threshold value to appropriate amount in USD. AWS reports billing in USD by default.
  dimensions = {
    Currency = "USD"
  }
  alarm_actions = [] # Add SNS topic ARN here if you want notifications
  period = 21600
}

# AWS Budgets - Free Tier usage alert (uses aws_budgets_budget)
resource "aws_budgets_budget" "free_tier_alert" {
  name = "${var.prefix}_free_tier_alert"
  budget_type = "USAGE"
  time_unit = "MONTHLY"

  limit_amount = "15" # example value - set appropriately
  limit_unit = "GB"   # depends on service; this is an example placeholder

  # Note: budgets require the account to have billing access configured.
  cost_filters = {}
  cost_types {
    include_credit = true
    include_other_subscription = true
  }
}
