
#Create an IAM Policy
resource "aws_iam_policy" "prototype-s3-policy" {
  name        = "S3-Bucket-Access-Policy"
  description = "Provides permission to access S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
        ]
        Effect   = "Allow"
        Resource = [

 "arn:aws:s3:::mybucketfordeltaprototyping/*" ]
      },
    ]
  })
}

#Create an IAM Role
resource "aws_iam_role" "prototype-role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "RoleForEC2"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}



resource "aws_iam_policy_attachment" "prototype-attach" {
  name       = "prototype-attachment"
  roles      = [aws_iam_role.prototype-role.name]
  policy_arn = aws_iam_policy.prototype-s3-policy.arn
}

resource "aws_iam_instance_profile" "prototype-profile" {
  name = "prototype_profile"
  role = aws_iam_role.prototype-role.name
}
