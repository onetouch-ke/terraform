# 1. Backup Vault
resource "aws_backup_vault" "bastion_backup_vault" {
  name = "bastion-backup-vault"
}

# 2. Backup Plan
resource "aws_backup_plan" "bastion_backup_plan" {
  name = "bastion-backup-plan-1h"

  lifecycle {
    create_before_destroy = true
  }

  rule {
    rule_name         = "every-1-hour-backup"
    target_vault_name = aws_backup_vault.bastion_backup_vault.name
    schedule          = "cron(0 * * * ? *)" # 정각마다
    start_window      = 65
    completion_window = 180
    lifecycle {
      delete_after = 1 # 테스트용으로 1일 후 삭제
    }
  }
}


# 3. Backup Selection (EC2 인스턴스 자체를 대상으로 지정)
resource "aws_backup_selection" "bastion_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "bastion-backup-selection"
  plan_id      = aws_backup_plan.bastion_backup_plan.id

  resources = [
    aws_instance.Monolith_pub_ec2_bastion_2a.arn
  ]
}

# 4. IAM Role for AWS Backup
resource "aws_iam_role" "backup_role" {
  name = "aws-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy_attachment" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
