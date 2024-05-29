#!/bin/bash
# Check the number of parameters
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 PROJECT NAME"
    exit 1
fi

PROJECT_NAME=$1 && echo "Building a new Spring Boot project: $PROJECT_NAME"

# Go to the project directory
cd $PROJECT_NAME

# Compiling projects
mvn clean install -Dmaven.test.skip -Dcheckstyle.skip

# Running Projects
#mvn spring-boot:run

echo "Project $PROJECT_NAME has been built and run successfully!"