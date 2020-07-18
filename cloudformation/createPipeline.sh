export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name hello-world-code-pipeline \
  --template-body file://CodePipeline.yml  \
  --parameters \
      ParameterKey=GithubOAuthToken,ParameterValue=4b7fbb3bc9d23e5ad14e2f949cd1aff92c5df860 \
  --capabilities CAPABILITY_IAM --profile infra-task-condenast

  aws cloudformation wait stack-create-complete --stack-name hello-world-code-pipeline
