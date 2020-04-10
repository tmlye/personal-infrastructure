# Need to use permanent credentials for doing backups
# because of the restricted session duration when assuming roles
resource "aws_iam_user" "this" {
  name = "UploadBackup"
}

resource "aws_iam_access_key" "this" {
  user    = aws_iam_user.this.name
  pgp_key = "keybase:${var.keybase_username}"
}
