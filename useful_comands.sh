## validate template
aws cloudformation validate-template \
    --template-body file://ec2_simple_example.yaml

## create stack
aws cloudformation create-stack \
    --stack-name example \
    --template-body file://ec2_simple_example.yaml \
    --parameters file://params.json

## update stack
aws cloudformation update-stack \
    --stack-name example \
    --template-body file://ec2_simple_example.yaml \
    --parameters file://params.json
## describe stack
aws cloudformation describe-stacks \
    --stack-name example \
    --query "Stacks[0].Outputs[0].OutputValue"

## delete stack
aws cloudformation delete-stack \
    --stack-name example

## create change set aka dry run
aws cloudformation create-change-set \
    --change-set-name changeset-1 \
    --stack-name example \
    --template-body file://ec2_simple_example.yaml \
    --parameters file://params2.json

## for not existing stack need to add --change-set-type CREATE
aws cloudformation create-change-set \
    --change-set-name changeset-1 \
    --change-set-type CREATE \
    --stack-name example \
    --template-body file://ec2_simple_example.yaml \
    --change-set-name changeset-1

## describe changes that will be applied
aws cloudformation describe-change-set \
    --change-set-name changeset-1 \
    --stack-name example \
    --query "Changes[].ResourceChange"

## describe changeset in a nicely way
aws cloudformation describe-change-set \
    --change-set-name changeset-1 \
    --stack-name example \
    --query 'Changes[*].ResourceChange.{Action:Action,Resource:ResourceType,ResourceId:LogicalResourceId,ReplacementNeeded:Replacement}' \
    --output table

## prevent updates to Stack Resources
aws cloudformation set-stack-policy \
    --stack-name example \
    --stack-policy-body file://stack-policy.json

## apply change set
aws cloudformation execute-change-set \
    --change-set-name changeset-1 \
    --stack-name example