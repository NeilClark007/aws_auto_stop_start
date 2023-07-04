# auto_stop_start
Repo to hold AWS Terrafrom code to configure auto_stop_start solution for DEV Environments

This code will create a new IAM Role for the Maintenance Window Automation to use to carry out automation
against EC2 instnaces identified by a tag.

The resource groups created by the code,  create two resource groups,  one called default and the other
called extended.  These resource groups are looking for the tag "auto_stop_start : default" and 
"auto_stop_start : extended" , you can alter create more to suit your requirements.

In the root varibles.tf file you will need to apply a role name to be used when the IAM module runs

In the root Main.tf file,  the first thing the terraform does is look up the caller identity,  the account_id 
is outputted to the outputs.tf file in the root.

the root main.tf file calls the modules as listed,  you will notice that variables are declared this is to 
make the variable value avaiable to the module,  the variable must be declared in the module variable.tf file as a 
blank variable if you want to use it.

To create the envrionment,

Clone the repo,  Update the variables.tf file in root to provide a role name. then run a Terraform init, then plan, then apply

*note make sure that the role you have assigned to allow terraform to deploy infrastrucutre has all the appropriate permissions
required to deploy this code.

