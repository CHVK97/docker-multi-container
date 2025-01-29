# docker-multi-container
# Deployment Script for Docker & Git

This repository contains a deployment script (`deploy.sh`) to automate setting up a Docker-based project and pushing it to GitHub and Docker Hub.

## Prerequisites
- Docker installed
- Git installed
- A GitHub repository set up
- A Docker Hub account

## Setup Instructions

### 1. Clone the Repository
```sh
git clone <your-repo-url>
cd <your-repo>
```

### 2. Configure Variables
Edit `deploy.sh` and update:
- `dockerhub_user="your-dockerhub-username"`
- `git_repo="your-repo-url"`

### 3. Run the Deployment Script
Make the script executable and run it:
```sh
chmod +x deploy.sh
./deploy.sh
```

## What the Script Does
1. Initializes a Git repository (if not already done)
2. Creates a `.gitignore` file
3. Sets up a Docker network
4. Builds and runs a MongoDB container
5. Builds, tags, and pushes a Node.js API container to Docker Hub
6. Runs the Node.js API container
7. Builds, tags, and pushes a React SPA container to Docker Hub
8. Runs the React SPA container
9. Commits changes and pushes to GitHub

## Stopping All Containers
To stop all running containers:
```sh
docker stop mongodb goals-backend goals-frontend
```

## Troubleshooting
- Ensure Docker and Git are installed and configured correctly.
- Verify that your Docker Hub credentials allow image pushing.
- Check for network issues if containers fail to communicate.

## License
This project is licensed under the MIT License.
