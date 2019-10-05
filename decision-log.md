# Repository Structure

## Drivers

- The individual components must be deployable independently
- It must be possible to share terraform modules between components

## Decision

- Keep terraform modules in a separate folder on top level
- Create folders for each component with their own terraform state
- Include the modules from the components
- Component folders can include other code like Ansible, microservice etc

# AWS account structure

## Drivers

- Personal infrastructure should be separate from side projects
- Common rules (AWS config, SCPs) should apply everywhere

## Decision

- Use AWS organizations to create a separate account for personal infrastructure
- Apply SCPs and AWS config to the entire organization
- Do create resources in the root/master account
