GenerateSpringBoot
=====

# Introduction

This is a group of scripts to generate a SpringBoot project.

# Tech stacks

- Java 17
- Spring Boot 3.2.1
- H2
- Spock（Groovy）
- JUnit（Java）

# Generate a SpringBoot project

### Give the script executable permissions

```shell
chmod +x generate-springboot-project.sh
chmod +x build-gradle-project.sh
chmod +x build-maven-project.sh
```

### Run the script to generate the SpringBoot project

```shell
./generate-springboot-project.sh springboot-project
```

### Compile the SpringBoot project using Gradle

```shell
./build-gradle-project.sh springboot-project
```

### Build the SpringBoot project using Maven

```shell
./build-maven-project.sh springboot-project
```

### Run the SpringBoot project

```shell
chmod +x start-springboot.sh
# gradle
./start-springboot.sh springboot-project gradle
# maven
./start-springboot.sh springboot-project maven
```

# Reference

