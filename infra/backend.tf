# Remote State Backend Configuration
# 
# SETUP INSTRUCTIONS:
# 1. Create S3 bucket:
#    aws s3 mb s3://YOUR-BUCKET-NAME-terraform-state --region us-east-1
#
# 2. Enable versioning:
#    aws s3api put-bucket-versioning \
#      --bucket YOUR-BUCKET-NAME-terraform-state \
#      --versioning-configuration Status=Enabled
#
# 3. Create DynamoDB table for locking:
#    aws dynamodb create-table \
#      --table-name terraform-state-lock \
#      --attribute-definitions AttributeName=LockID,AttributeType=S \
#      --key-schema AttributeName=LockID,KeyType=HASH \
#      --billing-mode PAY_PER_REQUEST \
#      --region us-east-1
#
# 4. Uncomment the backend block below
# 5. Run: terraform init -migrate-state
#
# terraform {
#   backend "s3" {
#     bucket         = "YOUR-BUCKET-NAME-terraform-state"
#     key            = "enterprise-obs/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-lock"
#   }
# }
