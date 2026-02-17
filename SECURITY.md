# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it responsibly:

**Please do not open a public GitHub issue for security vulnerabilities.**

For urgent security issues, contact via LinkedIn or open a private security advisory on GitHub.

## Secure Practices in This Project

✅ **Authentication & Authorization**
- No hardcoded credentials
- IAM least privilege principles
- IRSA (IAM Roles for Service Accounts) for pod authentication
- No static AWS credentials in containers

✅ **Network Security**
- Private subnets for all workloads
- Security groups with minimal access
- VPC endpoints ready for AWS service access
- OpenSearch domain within VPC only

✅ **Data Protection**
- Encrypted EBS volumes
- Encrypted data at rest in OpenSearch
- TLS in transit for all service communication

✅ **Infrastructure Security**
- No public SSH access
- EKS control plane logging enabled
- Container image scanning in ECR
- Regular security updates via managed node groups

✅ **Secrets Management**
- No secrets in code or state files
- Environment variables injected at runtime
- AWS Secrets Manager ready for integration

## Known Limitations (Development Setup)

⚠️ This is a **demo/portfolio project** with some security trade-offs for simplicity:

1. **OpenSearch access policy** allows root account access (production should use specific roles)
2. **No WAF** or advanced threat protection (cost optimization)
3. **No VPC endpoints** (adds cost, but recommended for production)
4. **Simplified RBAC** in Kubernetes (production needs granular policies)

## Security Checklist for Production Use

If adapting this project for production:

- [ ] Implement AWS Organizations with SCPs
- [ ] Enable AWS GuardDuty
- [ ] Set up AWS Config rules
- [ ] Implement VPC Flow Logs
- [ ] Add AWS WAF for API protection
- [ ] Enable EKS audit logging
- [ ] Implement pod security policies/standards
- [ ] Set up vulnerability scanning in CI/CD
- [ ] Implement secret rotation
- [ ] Add network policies in Kubernetes
- [ ] Enable MFA for all IAM users
- [ ] Implement automated compliance scanning

## Compliance

This project implements security controls aligned with:
- AWS Well-Architected Framework (Security Pillar)
- CIS Kubernetes Benchmark (partial)
- OWASP Container Security

## Updates

Security practices are reviewed quarterly and updated as AWS best practices evolve.
