# BetPulse — AWS Sports Betting Infrastructure

High-availability AWS infrastructure for a sports betting platform built to handle 500,000 concurrent users at NFL kickoff. Built entirely with Terraform IaC across 8 independent modules.

## Client Requirements
- 500,000 concurrent users at peak
- 10x traffic spike in 4 minutes
- RTO: 5 minutes maximum
- PCI-DSS SAQ-A compliance
- 6 state gambling licenses
- Real-time odds updates every 2-3 seconds
- $80-120k monthly budget

## Architecture — 8 Modules

| Module | Purpose |
|--------|---------|
| vpc | Private network layer that isolates all BetPulse infrastructure while allowing controlled internet access for users and external services |
| security | Security groups and access controls enforcing least-privilege networking between all services — PCI-DSS compliant |
| auth | Identity layer managing who users are, MFA enforcement, session tokens, and access control via Cognito |
| compute | Application layer running the Rails app on ECS Fargate with auto scaling to 50 containers and ALB load balancing |
| database | Encrypted PostgreSQL database storing user accounts, betting history, and payment records in an isolated subnet |
| cache | ElastiCache Redis caching high-frequency odds data so 500,000 users get sub-millisecond reads without hitting the database |
| pipeline | Real-time odds pipeline — EventBridge triggers Lambda every minute to poll Sportradar, Kinesis buffers the feed, Redis delivers updates to users |
| monitoring | CloudTrail audit logging, S3 bet record retention for 5 years, and SNS alerts for compliance and operational visibility |

## Tech Stack
- **IaC:** Terraform
- **Compute:** ECS Fargate + Auto Scaling
- **Database:** Aurora PostgreSQL Multi-AZ
- **Cache:** ElastiCache Redis
- **Auth:** Cognito + Lambda Authorizer
- **Pipeline:** EventBridge + Lambda + Kinesis

> **Note:** The Kinesis odds pipeline module is currently commented out. AWS Kinesis requires a service subscription not available on learner/sandbox accounts. The module code is complete and production-ready — deployment requires a standard AWS account. All other 7 modules deploy and run successfully via the CI/CD pipeline.
- **Security:** WAF + Security Groups
- **Audit:** CloudTrail + S3 + SNS

## Project Structure
aws-betpulse-sports-betting/
├── main.tf              # Root module — wires all 8 modules together
├── variables.tf         # Root variables
├── outputs.tf           # Root outputs
├── provider.tf          # AWS provider configuration
└── modules/
├── vpc/             # Network layer
├── security/        # Security groups
├── auth/            # Cognito authentication
├── compute/         # ECS Fargate + ALB
├── database/        # Aurora PostgreSQL
├── cache/           # ElastiCache Redis
├── pipeline/        # Odds pipeline
└── monitoring/      # Audit logging

## Deploy
```bash
# Initialize Terraform
terraform init

# Preview infrastructure
terraform plan -var="aws_account_id=YOUR_ACCOUNT_ID"

# Deploy
terraform apply -var="aws_account_id=YOUR_ACCOUNT_ID"

# Destroy
terraform destroy -var="aws_account_id=YOUR_ACCOUNT_ID"
```

## Key Design Decisions
- **Single VPC, Multi-AZ** — Covers all 6 US state licenses, designed for multi-region expansion
- **ECS Fargate over EC2** — 30 second container startup vs 3-5 minute EC2 cold start for 4 minute spike window
- **Redis for odds delivery** — 500,000 users read from cache, Aurora only handles writes
- **Scheduled pre-scaling** — Containers pre-warmed before kickoff, not reactive during spike
- **Per-state S3 partitioning** — Audit logs partitioned by state for regulator queries without network isolation overhead