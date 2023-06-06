## Comparison table

| **Characteristic**        | **Docker Compose** | **CodeBuild**    | **GitLab CI/CD**  | **CloudFormation**  | **AWS CDK**       | **Terraform**      |
| ------------------------- | ------------------ | ---------------- | ----------------- | ------------------- | ----------------- | ------------------ |
| **Language and Tools**    | YAML               | YAML (buildspec) | YAML (.gitlab-ci) | YAML/JSON           | Programming Lang. | HCL/JSON           |
| **Ease of Use**           | Easy               | Moderate         | Easy              | Moderate            | Moderate          | Moderate           |
| **Clear to Understand**   | Yes                | Yes              | Yes               | Yes                 | Yes               | Yes                |
| **Costs**                 | -                  | AWS usage-based  | GitLab SaaS       | -                   | -                 | -                  |
| **Community and Support** | Large              | Large            | Large             | Large               | Large             | Large              |
| **Maturity of the Tool**  | Mature             | Mature           | Mature            | Mature              | Growing           | Mature             |
| **Potential Issues**      | Limited scale      | AWS dependency   | GitLab dependency | Template complexity | Learning curve    | HCL Learning curve |

## Proposed Tools

Based on the analysis, the proposed tools for the project would be as follows:

- Managing Local Environment: Docker Compose
  Build and Automation: CodeBuild (if the team is familiar with AWS services) or GitLab CI/CD (for an integrated GitLab ecosystem)

- Infrastructure Management (IaC): CloudFormation (for native AWS integration, rollback, and change management) or AWS CDK (for more flexibility and programmability)

The final choice between CloudFormation and AWS CDK would depend on factors such as the team's familiarity with programming languages and the level of control and flexibility required for managing the infrastructure.
