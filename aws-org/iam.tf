resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_group" "admins" {
  name = "Admins"
}

resource "aws_iam_user_group_membership" "terraform_admins" {
  user = aws_iam_user.terraform.name

  groups = [
    aws_iam_group.admins.name
  ]
}

resource "aws_iam_group_policy_attachment" "admins" {
  group      = aws_iam_group.admins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
