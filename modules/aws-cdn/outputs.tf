output "bucket_id" {
  description = "S3 bucket ID."
  value       = aws_s3_bucket.static.id
}

output "bucket_arn" {
  description = "S3 bucket ARN."
  value       = aws_s3_bucket.static.arn
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID."
  value       = aws_cloudfront_distribution.cdn.id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain (e.g. d1234abcd.cloudfront.net)."
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "CloudFront hosted zone ID."
  value       = aws_cloudfront_distribution.cdn.hosted_zone_id
}

output "origin_url" {
  description = "HTTPS URL to the primary origin."
  value       = "https://${aws_cloudfront_distribution.cdn.domain_name}"
}
