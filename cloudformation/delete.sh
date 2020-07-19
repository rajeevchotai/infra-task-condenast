# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation delete-stack --stack-name dev-<aws-account-id>-FargateECSCluster --profile infra-task-condenast
aws cloudformation wait stack-delete-complete --stack-name dev-<aws-account-id>-FargateECSCluster --profile infra-task-condenast

aws cloudformation delete-stack --stack-name hello-world-code-pipeline --profile infra-task-condenast
aws cloudformation wait stack-delete-complete --stack-name hello-world-code-pipeline --profile infra-task-condenast
