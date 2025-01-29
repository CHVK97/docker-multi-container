#!/bin/bash

# Set variables
dockerhub_user="your-dockerhub-username"
git_repo="your-repo-url"

# Initialize Git Repository
git init
git remote add origin $git_repo

echo "node_modules/
logs/
data/
*.env" > .gitignore

# Create Docker Network
docker network create goals-net

# Run MongoDB Container
docker run --name mongodb \
  -e MONGO_INITDB_ROOT_USERNAME=max \
  -e MONGO_INITDB_ROOT_PASSWORD=secret \
  -v data:/data/db \
  --rm \
  -d \
  --network goals-net \
  mongo

# Build and Push Node API Image
docker build -t goals-node .
docker tag goals-node $dockerhub_user/goals-node:latest
docker push $dockerhub_user/goals-node:latest

# Run Node API Container
docker run --name goals-backend \
  -e MONGODB_USERNAME=max \
  -e MONGODB_PASSWORD=secret \
  -v logs:/app/logs \
  -v /app/node_modules \
  --rm \
  -d \
  --network goals-net \
  -p 80:80 \
  $dockerhub_user/goals-node:latest

# Build and Push React SPA Image
docker build -t goals-react .
docker tag goals-react $dockerhub_user/goals-react:latest
docker push $dockerhub_user/goals-react:latest

# Run React SPA Container
docker run --name goals-frontend \
  -v /Users/development/teaching/udemy/docker-complete/frontend/src:/app/src \
  --rm \
  -d \
  -p 3000:3000 \
  -it \
  $dockerhub_user/goals-react:latest

# Commit and Push to GitHub
git add .
git commit -m "Initial Docker setup"
git push origin main

echo "Deployment completed successfully!"
