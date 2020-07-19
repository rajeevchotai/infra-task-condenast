# Hello World CloudFormation
This repository contains a Hello World Deployment on AWS using [AWS Cloudformation](https://aws.amazon.com/cloudformation/). 

The CloudFormation template creates an ECS cluster and a CI/CD Pipeline with following components:

- AWS CodePipeline
- AWS ECR
- AWS VPC with 2 Subnets
- Application Load Balancer
- Internet Gateway
- Fargate ECS Cluster

The Cloudformation templates are present in the [cloudformation/](cloudformation/) directory

The sample container application is a Java Spring Boot hello world app in the  [aws-hello-world/](aws-hello-world/) directory

## Solution
The solution is to deploy only the CI/CD Pipeline using a Cloudformation template and once it succeeds on creating the Docker image, deploy the next Cloudformation template containing the Fargate ECS Cluster infrastructure using this pipeline itself.

## Cloudformation Multi-Stage Compatibility
In order to make the Cloudformation template compatible for multiple stages (Dev, QA or any other), all resources defined in the template will have their name combined with stage name and AWS account Id appended to make sure the uniqueness of the resource.
For example a resource name would consist of following,

`Stage name + AWS Account Id + Resource name`

## AWS CodePipeline
AWS CodePipeline will be used to build and deploy the application along with the AWS infrastructure needed.
AWS CodePipeline will be created using a Cloudformation template and this will be done by the user manually in the console. This will trigger the CI/CD Pipeline deployment and then later the deployment of Cloudformation template consisting of the Fargate ECS Cluster.

There are 3 stages in AWS CodePipeline.
1. **Source Stage**: 
    Source provider will be Github in this case. This stage authenticates with Github via a user provided Github access token and pulls the source code from the Github repository.
2. **Build Stage**: 
    Build provider will be AWS CodeBuild in this case. it will be used for following tasks,
    - Build the Docker image.
    - Push the Docker image to the ECR.
    - Output Docker ECR image URL to a JSON file saved in a S3 bucket so the deploy stage can use it.
3. **Deploy Stage**:
    Deploy provider will be Cloudformation in this case. This stage will receive the source code pulled from Github as an input artifact which contains the Cloudformation template it should deploy. 

Please refer to the application architecture below for a better understanding.

## Application Architecture

![Infra](/app-arch.png)

## Deploying Infrastructure

The main steps of the deployment process can be identified as below
1. User manually deploys the initial Cloudformation template containing the CodePipeline infrastructure (CodePipeline.yml).
2. Cloudformation starts the deployment of the AWS CodePipeline infrastructure.
3. After the Cloudformation deployment, CodePipeline pulls the source code from Github in the source stage.
4. CodePipeline builds the docker image and pushes to the ECR in the build stage using AWS CodeBuild service.
5. CodePipeline starts the deployment of the Cloudformation template (Fargate-Cluster.yml) containing Fargate ECS Cluster in the deploy stage.

To summarise, there will be 2 Cloudformation template deployments. The first one will be done by the user which will create an AWS CodePipeline and then the second one will be done by the AWS CodePipeline itself.

First, you'll need to create an [AWS account](https://portal.aws.amazon.com/billing/signup#/start). Then fork this repo into your own Github account as we need to provide the Github personal access tokens which will be account specific and perform the following steps:

1. `cd` into the [cloudformation/](cloudformation/) directory:
2. Create Github personal access token file as explained [here](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).
3. Populate [credentials](/README.md#credentials) file.
4. Update `createPipeline.sh` with your Github username, repo and oauth token and run `./createPipeline.sh`.


### Credentials
Run `aws configure --profile infra-tasks-condenast` and provide the below:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name
- Default output format
