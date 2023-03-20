# Consul-Module
Terraform configuration files that creates a Consul module that spins up a Consul cluster in AWS. 
Creation of module to spin up a Consul cluster in AWS. 

**Prerequisites:** 

    Terraform 

    Consul 

Module: 

**Main.tf** - This file consists of the creation of the 3 EC2 instances that I will be using as a node. The user data part is where it is tasked to install consul on the instances that this module will create, in this case it is 3 instances. _(It is required to create 3 instances when using consul because it automatically nominates a leader within the cluster and you need 3 for majority.)_ 

**Variables.tf** - This is the variables file which consists of the variables that I used for the module so that it would not be hard coded into the terraform code. Also, it would be easier to change in the future if you decide to change some variables. 

**Vpc.tf** - This is the vpc configuration file wherein I used a cidr block of 10.0.0.0/16. I used the ${count.index} so that the subnet would be created automatically based on the index.  

**Igw.tf** - To connect my instances in AWS using local computer.  

**Routetable.tf** - The route table is used to determine where traffic from my subnets is directed. I associated the subnets in the aws_route_table_association block.  

**Sg.tf** - This is the security group configuration file that determines which ports and traffic are allowed. I allowed ingress of 8300, 8500 _(for http)_, 22 _(for ssh)_ and egress for all.  

**Outputs.tf** - This is to output the public ip’s of my instances after I terraform apply the resources. A great practice to create outputs so that we do not need to access the console for other necessary information.  

To use this module, create another directory containing a new main.tf and variables.tf files _(this is not required, this is just another way of accessing modules)_

    provider "aws"{
        region = <region>
        
    module "consul-cluster {
        source = <folder or directory where your module is created>
        *input the necessary arguments needed. E.G. cluster size, ami and instance type.*

You can now use terraform init, terraform plan and apply. 
After terraform apply, you can connect to the instances or nodes via ssh using: 

    ssh -i "keypair_name.pem" ec2-user@<public-ip-of-your-instance> 

After you established connection to the SSH, start the consul service with the command: 

    sudo systemctl start consul 

If you need to restart your consul service, use this command: 

    sudo systemctl restart consul 

If you need to edit the configuration files of consul, use this command: 

    sudo nano /etc/consul.d/consul.hcl 

Add the client nodes on to the server by using the command: 

    consul join <ip of server> 

After doing that, you can now verify the nodes of your cluster using consul members

To access the console of consul, you need to provide some commands: 

     consul agent –dev –client=0.0.0.0 

After inputting that command, you can now access console via browser by using the publicip and :8500 port. Type in <publicip>:8500  

 
