# DevOps Internship Task 2 — Jenkins CI/CD Pipeline

## Objective
Automate the building, testing, and deployment of a static website using Jenkins and Docker.

## Tools
- Git and GitHub
- Jenkins (Linux agent with Docker CLI and permission to access Docker daemon)
- Docker
- Nginx

## CI/CD workflow
GitHub push → Jenkins SCM polling (about every two minutes) → Checkout → Docker Build → Test → Deploy.

## Files
- `Jenkinsfile`: Declarative Jenkins CI/CD pipeline with SCM polling.
- `Dockerfile`: Builds a lightweight Nginx website image.
- `index.html`: Sample website.
- `tests/test_site.sh`: Simple automated checks for the site and configuration.
- `screenshots/`: Add screenshots of successful builds and running website.

## Prerequisites
1. Docker daemon running on host.
2. Jenkins running at `http://localhost:8081` with Pipeline and Git plugins.
3. The Jenkins agent can run `docker ps` and `docker build`.
4. Port 8090 available on host.
5. Repository publicly cloneable or credentials configured in Jenkins.

## Local test
```sh
sh tests/test_site.sh
docker build -t devops-task2-web:local .
docker run -d --name task2-local -p 8090:80 devops-task2-web:local
```
Open http://localhost:8090. To remove the local test container:
```sh
docker rm -f task2-local
```
Do not run this local-test container on port 8090 while deploying with Jenkins.

## Jenkins configuration
1. Dashboard → New Item → `task2-jenkins-cicd` → Pipeline.
2. Pipeline → Definition: `Pipeline script from SCM`.
3. SCM: `Git`, URL: your GitHub repository HTTPS clone URL.
4. Branch specifier: `*/main`; script path: `Jenkinsfile`.
5. Save → Build Now. The Jenkinsfile includes an SCM polling trigger for future pushes.

## Automatic redeployment demonstration
1. After the first successful build, change `Version 1` to `Version 2` in `index.html`.
2. Update `tests/test_site.sh` to check for `Version 2`.
3. Commit and push both changes.
4. SCM polling detects changes and runs a new build, generally within two minutes.
5. Reload http://localhost:8090 and capture evidence.

## Evidence
Add screenshots for Jenkins green build, console output, Docker `docker ps`, and the running website.

## Notes
This is a local lab deployment, not a publicly hosted website. Jenkins SCM polling is used because GitHub cannot send a webhook directly to a private `localhost` address.
