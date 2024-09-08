resource "aws_iam_role" "role_manage" {
  name = "manage_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.role_manage.name
 policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
