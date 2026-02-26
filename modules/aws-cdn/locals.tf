locals {
  bucket_name  = "${var.name_prefix}-static-host"
  s3_origin_id = "${var.name_prefix}-s3-origin"
}
