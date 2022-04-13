# Demo Backstage Infra



## Overview

That's the repository to Infrastructure of Backstage project.

### Tools

- [AWS Lightsail](https://docs.aws.amazon.com/lightsail/)
- [CircleCI](https://circleci.com/docs/)
- [Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [MicroK8s](https://microk8s.io/docs)

### Running local

- Shared services [here](terraform/demo_terraform_aws_shared/TEST_ENV.md)
- Lightsail [here](terraform/demo_terraform_aws_lightsail/TEST_ENV.md)

### Developing

Clone this repo and we use a [GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow#:~:text=Gitflow%20is%20a%20legacy%20Git,software%20development%20and%20DevOps%20practices.) process and we have theses branches:

- `main` -> (Freeze branch)
- `feature/my_example_feature` -> (To new implementations)
- `hotfix/my_hotfix_name` -> (To Hotfixes)

To commits include a soon description what is the implemented in process. Example: `git commit -m "Implementation a tests of infra`
