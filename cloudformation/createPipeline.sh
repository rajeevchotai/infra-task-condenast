export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name hello-world-code-pipeline \
  --template-body file://CodePipeline.yml  \
  --parameters \
      ParameterKey=GithubOAuthToken,ParameterValue=cf2d64716b7fb4e951609e24e1d6b0432819c2ad \
  --capabilities CAPABILITY_IAM --profile infra-task-condenast

  aws cloudformation wait stack-create-complete --stack-name hello-world-code-pipeline --profile infra-task-condenast
