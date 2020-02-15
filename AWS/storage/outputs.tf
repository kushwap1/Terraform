# storage out

output "bucketname" {
  value = "${aws_s3_bucket.new.id}"
}
