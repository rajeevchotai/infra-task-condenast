# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""


aws cloudformation delete-stack --stack-name hello-world-code-pipeline
aws cloudformation wait stack-delete-complete --stack-name hello-world-code-pipeline

aws cloudformation delete-stack --stack-name dev-FargateECSCluster
aws cloudformation wait stack-delete-complete --stack-name dev-FargateECSCluster
