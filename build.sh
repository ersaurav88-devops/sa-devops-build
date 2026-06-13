#!/bin/bash

echo "Building Docker Image"

docker build -t shouravawasthi/devops-build:latest .

echo "Build Complete"
