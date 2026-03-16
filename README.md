# Terraform EKS Cluster Deployment

This project automates the deployment of a production-ready Amazon EKS (Elastic Kubernetes Service) cluster using Terraform and GitLab CI/CD.

## Project Architecture

The infrastructure is organized into several modular components:

- **VPC Module**: Sets up the network foundation, including VPC, subnets across multiple availability zones, and routing.
- **IAM Module**: Manages the necessary IAM roles and policies for the EKS cluster and worker nodes.
- **Security Module**: Configures security groups for the cluster and worker nodes to control traffic.
- **EKS Module**: Provisions the core EKS cluster, specifying the Kubernetes version and network configuration.
- **Nodegroup Module**: Deploys managed worker node groups with configurable instance types and scaling parameters.

## Prerequisites

- **Terraform**: version 1.3.7 or higher.
- **AWS Credentials**: Configured with appropriate permissions to create EKS, VPC, and IAM resources.
- **GitLab CI/CD**: Runner configured with Terraform image `hashicorp/terraform:1.3.7`.

## Configuration

The following variables are used to customize the deployment (see [variables.tf](file:///Users/nkalapala/Documents/Learnings/terraform-eks/variables.tf)):

| Name | Description | Default |
| :--- | :--- | :--- |
| `region` | AWS region to deploy resources | `us-east-1` |
| `cluster_name` | Name of the EKS cluster | - |
| `kubernetes_version` | Kubernetes version for the cluster | - |
| `vpc_cidr_block` | CIDR block for the VPC | - |
| `subnet_cidr_blocks` | List of CIDR blocks for subnets | - |
| `availability_zones` | List of AZs for subnets | - |
| `instance_type` | EC2 instance type for worker nodes | - |
| `desired_size` | Desired number of worker nodes | - |
| `min_size` | Minimum number of worker nodes | - |
| `max_size` | Maximum number of worker nodes | - |
| `tag` | Tag prefix for resources | `nav-eks` |

## CI/CD Pipeline

The project includes a robust GitLab CI/CD pipeline defined in [.gitlab-ci.yml](file:///Users/nkalapala/Documents/Learnings/terraform-eks/.gitlab-ci.yml).

### Stages

1. **terraform-validate**: Runs `fmt` and `validate` on every commit.
2. **terraform-plan**: Generates a Terraform execution plan (`tfplan`).
3. **terraform-apply**: Manually triggered stage to apply the plan and deploy infrastructure.
4. **terraform-destroy**: Manually triggered stages to plan and execute infrastructure destruction.

### Operations

The pipeline uses an `OPERATION` variable to control which actions are performed. You can set this variable when manually triggering a pipeline:
- `validate` (default)
- `plan`
- `apply`
- `destroy`

## Usage (Local Development)

To work on this project locally:

1.  **Initialize Terraform**:
    ```bash
    terraform init
    ```

2.  **Plan changes**:
    ```bash
    terraform plan
    ```

3.  **Apply changes**:
    ```bash
    terraform apply
    ```

4.  **Destroy resources**:
    ```bash
    terraform destroy
    ```


