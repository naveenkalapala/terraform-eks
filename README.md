# Terraform EKS Cluster Deployment

Automated deployment of an Amazon EKS cluster using Terraform modules and GitLab CI/CD.

## Architecture

```
┌──────────────────────────────────────────────────┐
│                    AWS Account                   │
│                                                  │
│  ┌──────────── VPC (10.0.0.0/16) ─────────────┐ │
│  │                                             │ │
│  │  ┌─────────────┐      ┌─────────────┐      │ │
│  │  │  Subnet-1   │      │  Subnet-2   │      │ │
│  │  │ us-east-1a  │      │ us-east-1b  │      │ │
│  │  │ 10.0.1.0/24 │      │ 10.0.2.0/24 │      │ │
│  │  └──────┬──────┘      └──────┬──────┘      │ │
│  │         │                    │              │ │
│  │         └────────┬───────────┘              │ │
│  │                  │                          │ │
│  │         ┌────────┴────────┐                 │ │
│  │         │   EKS Cluster   │                 │ │
│  │         │  (Control Plane)│                 │ │
│  │         └────────┬────────┘                 │ │
│  │                  │                          │ │
│  │         ┌────────┴────────┐                 │ │
│  │         │   Node Group    │                 │ │
│  │         │  (Worker Nodes) │                 │ │
│  │         │  t2.micro × 2   │                 │ │
│  │         └─────────────────┘                 │ │
│  │                                             │ │
│  └─────────────────────────────────────────────┘ │
│                                                  │
│  IAM Roles: cluster-role, worker-node-role       │
│  Security Groups: cluster-sg, worker-node-sg     │
└──────────────────────────────────────────────────┘
```

## Module Structure

```
terraform-eks/
├── main.tf              # Wires all modules together
├── variables.tf         # Input variables
├── terraform.tfvars     # Variable values
├── provider.tf          # AWS provider config
├── .gitlab-ci.yml       # CI/CD pipeline
└── modules/
    ├── vpc/             # VPC, subnets, IGW, route tables
    ├── iam/             # EKS cluster & node IAM roles
    ├── security/        # Cluster & worker node security groups
    ├── eks/             # EKS cluster control plane
    └── nodegroup/       # Managed worker node group
```

### Module Dependency Flow

```
VPC ──┐
IAM ──┼──→ EKS ──→ NodeGroup
SG ───┘
```

## Prerequisites

- Terraform >= 1.3.7
- AWS credentials with EKS, VPC, and IAM permissions
- GitLab runner (for CI/CD)

## Configuration

| Variable | Description | Default |
|:---|:---|:---|
| `region` | AWS region | `us-east-1` |
| `cluster_name` | EKS cluster name | `nav-eks-demo` |
| `kubernetes_version` | Kubernetes version | `1.32` |
| `vpc_cidr_block` | VPC CIDR block | `10.0.0.0/16` |
| `subnet_cidr_blocks` | Subnet CIDR blocks | `["10.0.1.0/24", "10.0.2.0/24"]` |
| `availability_zones` | Availability zones | `["us-east-1a", "us-east-1b"]` |
| `instance_type` | Worker node instance type | `t2.micro` |
| `desired_size` | Desired worker nodes | `2` |
| `min_size` | Minimum worker nodes | `1` |
| `max_size` | Maximum worker nodes | `3` |
| `tag` | Tag prefix for resources | `eks` |

## CI/CD Pipeline

Defined in [.gitlab-ci.yml](.gitlab-ci.yml). Select the `OPERATION` variable when triggering a pipeline:

| Operation | Stage | Trigger |
|:---|:---|:---|
| `validate` | terraform-validate | Automatic |
| `plan` | terraform-plan | Automatic |
| `apply` | terraform-apply | Manual click |
| `destroy` | terraform-destroy | Manual click |

## Local Usage

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```


