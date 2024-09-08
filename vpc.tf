
#  MyFirst_vpc  
resource "aws_vpc" "MyFirst_vpc" {
  cidr_block = "10.0.0.0/16"
}
#aws_vpc_endpoint" 
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.MyFirst_vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
}
