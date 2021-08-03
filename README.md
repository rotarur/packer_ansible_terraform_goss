# packer_ansible_terraform_goss
This repository is an example of packer + ansible + terraform + goss.

It's using [Goss](https://github.com/aelsabbahy/goss) tool to do some unit tests on services running, like iptables and ssh

Ansible instals the iptables and configure it to being accessible on port 22.

Terraform uses the custom AMI created by searching for it using `aws_ami` resource. It's creating also the key pair to access the instance.

When terraform finishes to create the resources it prints out the NLB domain that can be used to access the instance.

The final architecture is an NLB in front with an instance in private subnet running in an autoscalig group.

## Structure
1. **ansible**
   1. `bastion.yaml` - ansible code to configure the AMI, install iptables and configure it and reconfigure the ssh with some basic security statements.
   2. `goss.yaml` - goss checks to be performed in the instance on build time.
2. **scripts**
   1. `bootstrap.sh` - botstrap script to instanle ansible. It should have a minimal set of commands as the responsible fo the job should be the ansible.
3. **terraform**
   1. I wont describe all files as I think they are self explanatory and I tried to have a minimal separation by terraform resources(maybe too much separation for this small case).
4. `packer-build.json` - packer definition to build the AMI

## How to use
1. If you have `aws_access_key` and `aws_secret_key` please change them in `packer-build.json` file accordingly. If you're using some sort of autoconfigured environment with roles then don't need to specify them.
2. Change `region` (aws region) accordingly in `packer-build.json`
3. `vpc_id` and `subnet_id` are temporary resources to build the AMI. Change them with your own ID's. I recommend to use public subnet for this step.
4. Execute `packer build -machine-readable packer-build.json`
5.  `cd ./terraform`
6. `vpc_id`, `public_subnet_id` and `private_subnet_id` from [vars.tf](./.terraform/vars.tf)change to your existing VPC and the subnet ID should be private as this is a bastion server with NLB in front
7. `terraform init`
8. `terraform plan`
9. `terraform apply`
10. The terraform will create a local key file named `example.pem` to access the bastion.
11. In the end of terraform apply it will output the DNS name of NLB that was assigned to the instance and to access it execute this:
    1.  `ssh <DNS_NAME> -l ec2-user -i example.pem`