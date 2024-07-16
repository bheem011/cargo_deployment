#!/bin/bash

# AWS Region
# Choose the desire aws region name below
AWS_REGION="ap-south-1"

# Local Docker Image Name
# Choose image and repo name as your choice
IMAGE_NAME="nodejs"
REPO_NAME="nodejs-repo"

# Set AWS credentials from environment variables
# Set the below environmental variable for the terminal/ terminal session 
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export DB_USER=$DB_USER
export DB_PASSWORD=$DB_PASSWORD
export DB_DATABASE=$DB_DATABASE

# Login to ECR
echo "Logging in to ECR..."
aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com
# Sample command : aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 99299999990738.dkr.ecr.ap-south-1.amazonaws.com

# Execute Terraform commands
echo "Executing Terraform commands..."
cd cargo/terraform
terraform init
terraform validate
terraform apply -var aws_access_key=$AWS_ACCESS_KEY_ID -var aws_secret_key=$AWS_SECRET_ACCESS_KEY -var username=$DB_USER -var password=$DB_PASSWORD


# Build Docker Image
cd ../..
echo "Building Docker Image..."
docker build -t $IMAGE_NAME .

# Tag Docker Image
echo "Tagging Docker Image..."
docker tag $IMAGE_NAME:latest aws_account_id.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_NAME
# Sample command : docker tag $IMAGE_NAME:latest 99299999990738.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_NAME

# Push Docker Image to ECR
echo "Pushing Docker Image to ECR..."
docker push aws_account_id.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_NAME
# Sample command : docker push 992382590738.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_NAME




#configure the aws
#aws configure

# echo "deploying container to aws..."
#aws lightsail create-container-service-deployment --service-name nodejs --cli-input-json file://deploy.json


