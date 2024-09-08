resource "aws_ebs_volume" "ex_volume" {
  availability_zone = "us-east-1a"
  size              = 40

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = aws_ebs_volume.ex_volume.id

  tags = {
    Name = "HelloWorld_snap"
  }
}


resource "aws_ami" "example" {
  name                = "terraform-example"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  imds_support        = "v2.0" # Enforce usage of IMDSv2. You can safely remove this line if your application explicitly doesn't support it.
  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = aws_ebs_snapshot.example_snapshot.id 
    volume_size = 40
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance-profile"
  role = aws_iam_role.role_manage.name
}
resource "aws_instance" "ex" {
  ami =aws_ami.example.id
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
}
