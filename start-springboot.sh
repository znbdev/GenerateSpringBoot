#!/bin/bash
# Check the number of parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 PROJECT NAME and maven or gradle"
    exit 1
fi

PROJECT_NAME=$1 && echo "Running Spring Boot project: $PROJECT_NAME"

# 变量
if [ "$2" = "maven" ]; then
    JAR_PATH="./$PROJECT_NAME/target/$PROJECT_NAME-0.0.1-SNAPSHOT.jar"
    LOG_PATH="./$PROJECT_NAME/target/output.log"
elif [ "$2" = "gradle" ]; then
    JAR_PATH="./$PROJECT_NAME/build/libs/$PROJECT_NAME-0.0.1-SNAPSHOT.jar"
    LOG_PATH="./$PROJECT_NAME/build/libs/output.log"
else
    echo "Unknown build tool, setting to mavne or gradle"
    exit 1
fi

PORT=8080

# Check if lsof exists, if it doesn't, install it.
if ! command -v lsof &> /dev/null
then
    echo "The lsof command was not found. Installing..."
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install lsof -y
    elif [ -f /etc/redhat-release ]; then
        sudo yum install lsof -y
    else
        echo "Unknown operating system, unable to install lsof"
        exit 1
    fi
fi

# Function: kills the process using the specified port
kill_process_using_port() {
    local port=$1
    local pid=$(sudo lsof -t -i:$port)

    if [ -n "$pid" ]; then
        echo "Kill process $port using $pid"
        sudo kill -9 $pid
    else
        echo "No process uses the port $port"
    fi
}

# Kill processes using default port 8080
kill_process_using_port $PORT

# If port 8080 is still occupied, exit the script
if sudo lsof -i:$PORT; then
    echo "Port $PORT is still occupied.。"
    exit 1
fi

# Launching the application
echo "Starting a Spring Boot Application..."
nohup java -jar $JAR_PATH > $LOG_PATH 2>&1 &