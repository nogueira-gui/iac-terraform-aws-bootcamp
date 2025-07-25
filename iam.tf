# Role compartilhada entre Users, Products e Orders para acesso ao RDS
resource "aws_iam_role" "ec2_rds_role" {
  name = "ec2-rds-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "rds_access" {
  name       = "ec2-rds-attach"
  roles      = [aws_iam_role.ec2_rds_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}
