# Terraform Cloud Setup

We're packaging in terraform code to express all of the infrastructure needed in order to deploy this app to an environment. The best way to handle terraform on a team is to have a remote state management solution so that anyone who makes changes to the infrastructure codebase can have access to the state. I like terraform cloud. 

## Setting up Terraform Cloud

### AWS
I'll be following the docs found [here](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions).

- <ins>**Make sure you have an account with terraform cloud.**</ins>    
    - Terraform Cloud can be found [here](https://app.terraform.io/).
- <ins>**Log in and create a workspace for your project.**</ins> 
    - Go to Projects and Workspaces. 
    - Click `New` and select `Workplace`.
    - Click on the `API-driven workflow` card.
    - Name your workspace and click `Create Workspace`.
- <ins>**Authenticate TF Cloud with AWS**</ins>
    - Add your AWS key and secret as environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
    - Mark them as sensitive.
- <ins>**Authenticate GitHub with TF Cloud**</ins>
    - Go to the tokens page.
    - Click `Create Token`.
    - Give the token a description and then copy it to your clipboard.
### GCP
(NOT TODAY, YO)

## CI/CD

