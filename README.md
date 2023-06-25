# Infrastructure as Code Repository

This repository serves as a storage for Infrastructure as Code (IaC) projects built on AWS, Azure, and GCP using Terraform and other tools. It organizes the contents of `.tf` configuration files for each platform and includes modules used to ensure standardization across different types of common resources. The primary goal of this project is to facilitate automated deployments and version control for IaC projects.

## Workflow
The projects in this repository follow a workflow that includes the use of various IaC tools. The specific workflow may vary depending on the project and platform requirements.

## Modules
Modules within this repository are primarily controlled and versioned using GitHub. They are designed to be reusable components that encapsulate specific infrastructure configurations. These modules can be referenced and utilized within the IaC projects.

Here is a list of available modules that can be referenced:

- [s3](https://github.com/carlos-castillo-a/s3-module)

## AWS
The following projects are connected to AWS:

- [aws001](./AWS/aws001/): Create an S3 bucket
- [aws002](./AWS/aws002/): Create an S3 bucket using a module

## Azure
The following projects are connected to Azure:

- [az001](./Azure/az001/): Create an App Service

## Google Cloud Platform
Projects for GCP are yet to be determined.

--

Feel free to organize your IaC projects within the respective platform folders and leverage the available modules to streamline your infrastructure deployments.