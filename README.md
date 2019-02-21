# Terraform Setup
This Terraform application sets up an ELB with appropriate security group configurations for secure web access.

## Resources Setup
### ELB (Classic Load Balancer)
The load balancer with name provided in `web_elb_name` will be created. It will use VPC and it's subnets specified in the inputs `compute_vpc_id` and `compute_subnets` respectively.

The ELB will listen on port `443` and will have unrestricted access (`0.0.0.0/0`) to it. It will forward the request to instance on port `8080`

The ELB access log will be enabled and shipped to the s3 location given in the `elb_access_log_config` variable and under the given elb name prefix.

**Note**
1. The specified s3 bucket should have appropriate permissions to allow elb to put logs into it.
2. The start of log delivery is delayed up to 5 minutes if the interval is set to 5 minutes, and up to 15 minutes if the interval is set to 60 minutes.

*Reference* - [Access Logs for Your Classic Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/access-log-collection.html)

The script outputs ELB's `Hosted Zone ID` and `Name` which can be used to configure in Route53.

## Security Groups
It creates and configures two security groups.
### 1. ELB Security Group
The ELB security group will have the following rules:

**Inbound**

|Type |Protocol|Port Range|Source   |
|-----|--------|----------|---------|
|HTTPS|TCP     |443        |0.0.0.0/0|

**Outbound**

|Type       |Protocol|Port Range|Destination|
|-----------|--------|----------|-----------|
|All Traffic|All     |All       |0.0.0.0/0  |

### 2. Instance Security Group

The Instance security group will have the following rules:

**Inbound**

|Type |Protocol|Port Range|Source       |
|-----|--------|----------|-------------|
|HTTP |TCP     |8080      |`<ELB SG ID>`|


**Outbound**

|Type       |Protocol|Port Range|Destination|
|-----------|--------|----------|-----------|
|All Traffic|All     |All       |0.0.0.0/0  |

## Running Terraform

##### Create workspace

```
terraform workspace create dev
```

##### Select workspace

```
terraform workspace select dev
```

##### Initialize Terraform
```
terraform init
```

##### Create Resources
```
terraform apply
```

##### Delete Resources
```
terraform destroy
```

## Input Variables

The input variables `aws_region`, `compute_vpc_id` and `compute_subnets` are to be configured in `terraform.tfvars` which is not uploaded to Git. Alternatively, in future iterations the aforementioned variables can be moved to environment variables as well.

The following are all the required input variables:
##### aws\_region
Description: The AWS region in which this infrastructure is to be deployed
Type: `string`

##### compute\_vpc\_id
Description: The VPC ID in which all compute resources will be deployed
Type: `string`

##### compute\_subnets
Description: Subnets over which the ELB will be deployed
Type: `list`

##### default\_tags
Description: Default tags that needs to be applied on all the resources
Type: `map`

##### web\_elb\_name
Description: Name used for the web ELB
Type: `string`

##### web\_elb\_ports
Description: ELB ports on which access will be allowed
Type: `list`

##### elb\_access\_log\_config
Description: Configurations required to ship ELB access logs to s3
Type: `map`

##### elb\_health\_check\_config
Description: ELB health check configuration
Type: `map`

##### elb\_listener\_config
Description: ELB listener configuration
Type: `map`

##### web\_instance\_name
Description: Name used for the web instance
Type: `string`

##### web\_instance\_ports
Description: Web instance ports on which access will be allowed
Type: `list`