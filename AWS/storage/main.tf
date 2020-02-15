# storage s3 main.tf

#random-id

resource "random_id" "new" {
  byte_length = 2
}

# Create bucket

resource "aws_s3_bucket" "new" {
  bucket = "${var.project_name}-${random_id.new.dec}"
  acl = "private"

  force_destroy = true

  tags = {
    owner = "Pankaj"
  }
}
