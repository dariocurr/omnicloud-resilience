variable "name_prefix" {
  description = "Prefix for resource names (e.g. project-environment)."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to supported resources."
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "AWS region for S3 and CloudFront."
  type        = string
}

variable "domain_aliases" {
  description = "Optional CNAMEs for the CloudFront distribution (e.g. www.example.com)."
  type        = list(string)
  default     = []
}

variable "price_class" {
  description = "CloudFront price class: PriceClass_All, PriceClass_200, or PriceClass_100."
  type        = string
  default     = "PriceClass_100"
}
