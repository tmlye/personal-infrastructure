resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_user_policy_attachment" "terraform" {
  user       = aws_iam_user.terraform.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
