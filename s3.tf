provider "aws" {
  region = "us-east-1"
}
/*
# object_lock_diabled
//////////////////////////////////////////////
*/
resource "aws_s3_bucket" "bucket_week_four" {
  bucket = "my-bucket-527"
  object_lock_enabled = false
  tags = {
    Name = "terraformChamps"
    Owner="Malek"
  }
}
/*
#creat director/
//////////////////////////////////////////////
*/
resource "aws_s3_object" "object_logs" {
  bucket = "my-bucket-527"
  key    = "logs/"
}
/*
# bucket_control 
//////////////////////////////////////////////
*/
resource "aws_s3_bucket_ownership_controls" "bucket_control" {
  bucket = aws_s3_bucket.bucket_week_four.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
/*
# aws_s3_bucket_public_access_block
//////////////////////////////////////////////
*/
resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.bucket_week_four.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
/*
# aws_s3_bucket_versioning
//////////////////////////////////////////////
*/
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket_week_four.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket_week_four.id
  versioning_configuration {
    status = "Enabled"
  }
}
/*
# encryption 
///////////////////////////////////
*/
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.bucket_week_four.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
} 
