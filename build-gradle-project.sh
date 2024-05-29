#!/bin/bash
# Check the number of parameters
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 PROJECT NAME"
    exit 1
fi

PROJECT_NAME=$1 && echo "Building a new Spring Boot project: $PROJECT_NAME"

# Copy the contents of gradle-file to the project directory
cp -r gradle-file/* $PROJECT_NAME/

# Go to the project directory
cd $PROJECT_NAME

# Compiling projects
./gradlew clean build --refresh-dependencies --stacktrace

echo "Project $PROJECT_NAME has been built successfully!"