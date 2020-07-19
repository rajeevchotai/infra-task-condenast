export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name hello-world-code-pipeline \
  --template-body file://CodePipeline.yml  \
  --parameters \
      ParameterKey=GithubOAuthToken,ParameterValue=<oauth-token> \
  --capabilities CAPABILITY_IAM --profile infra-task-condenast

  aws cloudformation wait stack-create-complete --stack-name hello-world-code-pipeline --profile infra-task-condenast
