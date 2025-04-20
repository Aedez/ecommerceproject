resource "aws_cloudwatch_metric_alarm" "rds_cpu_high" {
  alarm_name          = "High-RDS-CPU-Utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when CPU exceeds 80%"
  alarm_actions = [aws_sns_topic.rds_alerts.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.ecommerce.id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_storage_low" {
  alarm_name          = "Low-RDS-Free-Storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 4000000000  # 4 GB in bytes
  alarm_description   = "Alarm when free storage is less than 4GB"
  alarm_actions = [aws_sns_topic.rds_alerts.arn]

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.ecommerce.id
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_memory_low" {
  alarm_name          = "Low-RDS-Freeable-Memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 100000000  # 100 MB
  alarm_description   = "Alarm when memory is below 100MB"
  alarm_actions = [aws_sns_topic.rds_alerts.arn]
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.ecommerce.id
  }
}

resource "aws_sns_topic" "rds_alerts" {
  name = "rds-monitoring-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.rds_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email  # Your email address
}
