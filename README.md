# cargo_deployment
This repository contains helper files to create infrastructure on the aws cloud using terraform code generated by the cargo application

## Deployment steps : 

#### 1. Go to your application root directory and Download the build.sh and deploy.json file using : https://github.com/bheem011/cargo_deployment
 
#### 2. Edit the script accordingly, instruction mentioned in script itself using comments

#### 3. Run the build.sh 
It will create infrastructure on cloud and push the container to ecr

#### 4. Run the below commands to deploy container to service : 
aws configure
aws lightsail create-container-service-deployment --service-name nodejs --cli-input-json file://deploy.json

Note : Change the service name accordingly

