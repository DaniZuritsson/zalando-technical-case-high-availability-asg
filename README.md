# High-Availability & Elastic Infrastructure Layer (Zalando Technical Case)

An Enterprise-grade, production-ready, fully parameterized Terraform template designed to deploy a highly available, fault-tolerant, and auto-scaling web architecture on AWS.

## Business Scenario

During massive retail campaigns like Black Friday, user traffic surges exponentially within short windows. Rigid legacy infrastructures fail to respond rapidly, leading to service downtime and severe revenue loss. This project addresses this vulnerability by deploying an immutable, elastic cloud infrastructure layer that scales horizontally and heals automatically under traffic stress.

## Architecture Specifications

The infrastructure is structurally designed across separate physical Availability Zones (Multi-AZ) within the **Frankfurt (eu-central-1)** region to achieve a 99.99% uptime operational matrix:

- **Network Topology (`vpc.tf`):** A custom Virtual Private Cloud (VPC) segmented into 2 Public Subnets (isolated for the Application Load Balancer) and 2 Private Subnets (isolated for the compute application tier).

- **Perimetric Security (`security_groups.tf`):** Implements a strict Zero-Trust firewall architecture. EC2 instances run in private networks without public IPs, accepting traffic **strictly** if chained directly from the Application Load Balancer's security group identifier.

- **Elastic Compute Tier (`compute.tf`):** Orchestrates an Auto Scaling Group (ASG) linked with an immutable Launch Template. It tracks the latest official Ubuntu Server LTS release dynamically and runs an internal auto-healing baseline of 2 instances with an elastic ceiling of 4.

- **Automated Provisioning (`user_data.sh`):** Installs, configures, and initializes a high-performance Nginx web server layer on startup using a clean, native, and completely neutral system configuration script.

---

## Customization & Parameterization

This template is completely modular and detached from environmental footprints. Custom organization parameters can be easily adapted by populating input values.

### 1. Remote State Core (`backend.tf`)

Configure your corporate remote state components before initialization within the placeholder variables:

- `bucket`: The target secure global AWS S3 bucket name where the state file will be stored.

- `dynamodb_table`: The dedicated DynamoDB table used for distributed state locking.

### 2. Infrastructure Input Variable Matrix (`variables.tf`)

Tailor the environment parameters via standard input values without altering the underlying resource code logic:

| Variable Name          | Description                                            | Default / Requirement                                         |
| :--------------------- | :----------------------------------------------------- | :------------------------------------------------------------ | --- |
| `aws_region`           | Target AWS geographical deployment region              | `"eu-central-1"`                                              |
| `vpc_cidr`             | Core private IP network allocation range               | _User Input Required (e.g. "10.0.0.0/16")_                    |
| `public_subnet_cidrs`  | Array of 2 network ranges for public routing layers    | _User Input Required (e.g. ["10.0.1.0/24", "10.0.2.0/24"])_   |
| `private_subnet_cidrs` | Array of 2 network ranges for private isolation layers | _User Input Required (e.g. ["10.0.10.0/24", "10.0.20.0/24"])_ |
| `instance_type`        | Compute hardware footprint sizing specification        | `"t3.micro"`                                                  |     |

---

## Deployment Lifecycle Sequence

### Prerequisites

1. **AWS CLI v2** properly configured with appropriate IAM Administrative entitlements.

2. **Terraform CLI (v1.5.0+)** compiled locally.

### Step 1: Environmental Initialization

Initialize the backend architecture state channel and pull third-party infrastructure providers:

```bash
terraform init
```

### Step 2: Code Architecture Validation

Validate the code structural correctness and block dependencies to guarantee execution safety:

```bash
terraform validate
```

### Step 3: Predictive Infrastructure Planning

Run an evaluation plan to verify the delta blueprint before altering live target resources:

```bash
terraform plan
```

#### Step 4: Live Production Deployment

Execute the compilation layer against the AWS Cloud controller. Confirm the execution prompt by typing yes:

```bash
terraform apply
```

### Step 5: Application Interactivity Access

Upon success, the endpoint configuration controller will export the load balancer DNS endpoint on the terminal root. Paste it directly into any browser client:

### Terminal Output Example

```bash
alb_dns_name = "zalando-prod-alb-123456789.eu-central-1.elb.amazonaws.com"
```

## Infrastructure Decommissioning

To remove all provisioned cloud assets cleanly and eliminate structural cloud expenditure, run the teardown process:

```bash
terraform destroy
```

## Enterprise Engineering Patterns Implemented

Least Privilege Model: Public ingestion is strictly throttled to standard HTTP ports on the outer layer. Inside the perimeter, administrative entry channels are sealed.

Fault-Tolerant High Availability: Compute and networking nodes are mirrored across segmented availability data blocks to absorb infrastructure failures transparently.

Immutable Lifecycles: Enforces a create_before_destroy paradigm on launch layers to ensure zero-downtime upgrades when rolling out new core updates.
