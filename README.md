# gitops-with-kubernetes

## Google cloud
### Console UI
- Create a project
- Create a billing account
- Enable billing for the project
- Enable following APIs on the project
    - Identity and Access Management (IAM) API
    - Cloud Resource Manager API
    - IAM Service Account Credentials API
    - Security Token Service API
## gcloud CLI
- Run `gcloud init`
- Select login and choose the created project
- Run `gcloud auth application-default login`

## Pulumi
- Login to pulumi account from cli using `pulumi login`
### Setup OIDC authentication and authorization
- cd into `pulumi/gcp_oidc`
- Create a `ESC` environment using `esc env init [<org-name>/]<environment-name>`, where <org-name> is optional and defaults to Pulumi Cloud username
- Validate that your environment was created by running the `esc env ls` command which will list all of the environments that you have access to
- Create a stack for the project `pulumi stack init <stack_name>`
    - A stack is an isolated, independently configurable instance of a Pulumi program. Every Pulumi program is deployed to a stack.
- Configure input variables for the stack
    - `pulumi config set environmentName <your-environment-name>` # replace with your environment name
    - `pulumi config set gcp:project <your-project-id>` # replace with your GCP project ID
    - `pulumi config set workloadIdentityPoolId <your-workload-identity-pool-id>` # replace with your arbitrary workload_identity_pool_id
- Run `pulumi up -y`
- It shall output a yaml configuration
### Validating the OIDC Configuration
- Save your environment file and run the `pulumi env open <your-pulumi-org>/<your-environment>` command in the CLI.
### Clean-Up Resources
Once you are done, you can destroy all of the resources as well as the stack:
- pulumi destroy
- pulumi stack rm