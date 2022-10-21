# Getting-Started-With-Terraform-Github
I have always described terraform as an API Wrapper, and a great one at that.

You can use it instead of scripting tons of validations and REST calls for example.

Traditionally, it's used for IaC - Infrastructure as Code for various cloud services, but in recent times it has greatly expanded.

So what is Terraform exactly? It will create things you tell it to, and keep state of them.

Just note one very important detail, be careful making changes to the "resources" created in their native services, sites, etc. There is drift protection, but this is also why the plan stage is so important (more later)

## Use Case
Bob needs to stand up a HA (Highly Available) infrastructure in AWS. Bob could do this manually, which is a very very fallible process. Bob decides to utilize Terraform.

Bob figures out Terraform, writes it up, and deploys his infrastructure.

Three months later, Bob is told he needs to add two additional subnets.

Luckily, Bob has defined his subnets in terraform, and simply adds two more resource blocks.

Bob runs a terraform plan, and looks over the changes. Since it keeps state, it checks the config.

Bob sees nothing has changed since last deployment, and it successfully detects two updates.

Bob runs a terraform apply and the two subnets are created.

Later, Bob gets hit by a bus. He doesn't make it.

Luckily, Bob kept his state encrypted in version control, as well as his terraform.

Bob's team is not in the dark about how it was configured, and can repeat 100% of what Bob was doing.

That is, after they learn about the configuration, which luckily is easy to read.

## Instructions/Self-Paced Demo
- install terraform from [here](https://learn.hashicorp.com/tutorials/terraform/install-cli)
    - Run terraform --version to confirm that its installed
- install git from [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- if needed, create a github account and a PAT
- clone this repo (theres a magic clone button that should walk you through it, if needed ask)
- using a terminal, shell, command prompt, powershell, etc
    - navigate into the repo you cloned
    - terraform init
        - this will download the providers
    - terraform plan
        - this will prompt you for your access token
    - terraform apply
        - this will prompt you as well for your access token, and yes to confirm
- After apply, you'll see an output URL I have configured. Use this to go to your new repo you just created on your github account, leave this open
- Update the repo name, on line 7 of main.tf to "BobsYourUncle", make sure to save
- return to shell
    - terraform plan
        - You should see it picked up the name change and will be informed as such in terminal
    - terraform apply -auto-approve
        - note the output url changed
- Refresh the page, it'll either redirect or 404, 
- return to shell
    - terraform destroy
        - This will prompt you for your mandatory token again, and to type yes to confirm
- return to your browser and refresh, the repo will be gone

<b>NOTE</b> If a default value is not set in terraform.tfvars, or on the variables.tf variable declaration, you should be prompted at CLI for input.

## Terraform commands in a nutshell
Needed to pull down the providers, this is always ran when adding providers (or modules), only needs ran initially
```sh
terraform init
```
This is used to do a plan, think dry-run
```sh
terraform plan
```
This is used to apply (run the code creating the resources you have defined), auto approve is dangerous but used in this example for simplicity. It's optional. If not provided you'll be prompted to type yes
```sh
terraform apply -auto-approve
```
This is used to delete/destroy your defined resources <b>NEVER</b> destroy with auto approve, it's usually only for CLI Automation. Destroying will tear down whatever you stood up with terraform typically
```sh
terraform destroy -auto-approve
```

## Project Outline
<b>NOTE: You can have one single main.tf file with everything thrown it it but terraform.tfvars</b>
- main.tf
    - your infra, you can name files whatever like networking.tf, subnets.tf, repos.tf, etc
- outputs.tf
    - your outputs, which can be referenced via CLI and seen
- providers.tf
    - sometimes split with versions.tf, this is your providers configuration
    - multiple providers can be used
    - providers can be located [here](https://registry.terraform.io/browse/providers)
    - providers are sort of like SDKs and python packages and java packages
- variables.tf
    - These are your inputs
    - Can be validated
    - While you can declare a variable with just a name, always declare a type, future self and others will thank you
    - ALWAYS declare tokens and such as sensitive if using in code vs environment var setup (provider documentation instructs on environment variable names)
- terraform.tfvars
    - This is special, it's your "Defaults" so to speak especially for development
    - But wait, variables can be defaulted!?
        - Yes, yes they can. The difference is your Terraform should be re-usable, so during development of your TF code, terraform.tfvars is absolutely invaluable
        - Be sure to put terraform.tfvars in your .gitignore after configuring everything but tokens in it
        - After committing and ensuring it's not captured in version control anymore, you can add tokens
- lock file
    - Didn't look this up, it gets generated to lock your provider version
    - also states get locked while being accessed
- terraform.tfstate
    - This should be treated as a password
    - You don't see it here, it happens after a plan or apply
    - It contains all the details of the post provisioned configuration
        - This is more then just your outputs, but the ones not utilized typically
- terraform.tfstate.backup
    - Same as terraform.tfstate, treat as password
    - Same you won't see it in this repo, but will when you plan and apply
    - Please don't make me explain .backup.....

## Provider Documentation
- Root of Provider - usually has auth/config details
    - https://registry.terraform.io/providers/integrations/github/latest/docs
- Resource used - providers often have multiple resources
    - https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
- All Providers
    - https://registry.terraform.io/browse/providers

## Parsing the documentation, references, and other boring stuff
- Documentation usually has datasources and resources in the left sidebar
    - Resources are what gets created
    - Datasources are lookups based on (usually) an input value
    - referencing
        - datasources are data.datasource_type.datasource_name.property_name
        - resources are resource_type.resource_name.property_name
        - variables are var.var_name
        - locals are local.var_name

## Further Education
- Offical HashiCorp Learn site
    - https://learn.hashicorp.com/terraform

## In Closing
Terraform really is a fabulous and fantastic tool. It even has complex special providers out there such as shell provider, and local exec. There is also Terraform Cloud which is their cloud based version of Terraform with full API's for using it as a backend if so desired.

Terraform can be used in conjunction with Ansible for idempotent configuration management post infrastructure deployment via pipelines and scripts and such. There are other tools besides ansible to fill this role as well. <b>Be advised ansible is NOT for the faint of heart</b>

My personal favorite usage of terraform is "throw away" terraform, where I don't care about state preservation. I use it as an API wrapper for scripting far more quickly versus traditional scripting with validations. Who really wants to validate error codes for the 1000th time?