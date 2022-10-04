resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "billing-estimated-charges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  threshold           = var.billing_alarm_threshold
  alarm_actions       = [aws_sns_topic.admin.arn]
}

resource "aws_sns_topic" "admin" {
  name = "admin-notifications"
}

resource "aws_sns_topic_subscription" "admin_email" {
  endpoint  = var.admin_email
  protocol  = "email"
  topic_arn = aws_sns_topic.admin.arn
}
