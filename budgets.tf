resource "aws_budgets_budget" "blog_cost" {
  name              = "montly-blog-cost"
  budget_type       = "COST"
  limit_amount      = "7.50"
  limit_unit        = "CAD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2020-01-01_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["paulmarsicloud@gmail.com"]
  }
}