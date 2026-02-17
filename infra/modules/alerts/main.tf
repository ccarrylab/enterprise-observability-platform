resource "aws_sns_topic" "alerts" {
  name = "${var.name}-alerts"
  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "os_red" {
  alarm_name          = "${var.name}-opensearch-red"
  alarm_description   = "OpenSearch cluster status red"
  namespace           = "AWS/ES"
  metric_name         = "ClusterStatus.red"
  statistic           = "Maximum"
  period              = 60
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions = {
    DomainName = var.opensearch_name
    ClientId   = var.account_id
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]
  tags          = var.tags
}

resource "aws_cloudwatch_metric_alarm" "os_jvm_pressure" {
  alarm_name          = "${var.name}-opensearch-jvm-pressure"
  alarm_description   = "OpenSearch JVM memory pressure high"
  namespace           = "AWS/ES"
  metric_name         = "JVMMemoryPressure"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 2
  threshold           = 85
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    DomainName = var.opensearch_name
    ClientId   = var.account_id
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
  tags          = var.tags
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
