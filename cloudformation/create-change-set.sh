# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-change-set \
  --change-set-name update-hello-world-code-pipeline \
  --stack-name hello-world-code-pipeline \
  --template-body file://CodePipeline.yml  \
  --parameters \
      ParameterKey=GithubOAuthToken,ParameterValue=<oauth token> \
  --capabilities CAPABILITY_IAM --profile infra-task-condenast

aws cloudformation describe-change-set \
  --stack-name hello-world-code-pipeline \
  --change-set-name update-hello-world-code-pipeline --profile infra-task-condenast
