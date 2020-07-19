# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-change-set \
  --change-set-name update-hello-world-code-pipeline \
  --stack-name hello-world-code-pipeline \
  --template-body file://CodePipeline.yml  \
  --parameters \
      ParameterKey=GithubOAuthToken,ParameterValue=cf2d64716b7fb4e951609e24e1d6b0432819c2ad \
  --capabilities CAPABILITY_IAM --profile infra-task-condenast

aws cloudformation describe-change-set \
  --stack-name hello-world-code-pipeline \
  --change-set-name update-hello-world-code-pipeline --profile infra-task-condenast
