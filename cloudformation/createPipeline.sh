export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name hello-world-code-pipeline \
  --template-body file://CodePipeline.yml  \
  --parameters \
      ParameterKey=GithubOAuthToken,ParameterValue=2216f2c7e5ea89a55320be07e3eaefa704fc398b \
  --capabilities CAPABILITY_IAM --profile infra-task-condenast

  aws cloudformation wait stack-create-complete --stack-name hello-world-code-pipeline --profile infra-task-condenast
