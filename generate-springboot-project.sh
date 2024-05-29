#!/bin/bash
# Check the number of parameters
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 PROJECT NAME"
    exit 1
fi

# Project Basic Information
#PROJECT_NAME="springboot-project"
PROJECT_NAME=$1 && echo "Creating new Spring Boot project: $PROJECT_NAME"
GROUP="com.example"
VERSION="0.0.1-SNAPSHOT"
JAVA_VERSION="17"
SPRING_BOOT_VERSION="3.2.1"

# Create a project directory structure
mkdir -p $PROJECT_NAME/src/main/java/com/example/demo
mkdir -p $PROJECT_NAME/src/main/resources
mkdir -p $PROJECT_NAME/src/main/resources/templates
mkdir -p $PROJECT_NAME/src/test/java/com/example/demo
mkdir -p $PROJECT_NAME/src/test/resources
mkdir -p $PROJECT_NAME/src/test/groovy/com/example/demo

# Create the pom.xml file
cat > $PROJECT_NAME/pom.xml <<EOL
<project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>$GROUP</groupId>
    <artifactId>$PROJECT_NAME</artifactId>
    <version>$VERSION</version>
    <packaging>jar</packaging>

    <name>$PROJECT_NAME</name>
    <description>Demo project for Spring Boot</description>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>$SPRING_BOOT_VERSION</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>

    <properties>
        <java.version>$JAVA_VERSION</java.version>
        <maven.compiler.source>$JAVA_VERSION</maven.compiler.source>
        <maven.compiler.target>$JAVA_VERSION</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.spockframework</groupId>
            <artifactId>spock-core</artifactId>
            <version>2.3-groovy-3.0</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.codehaus.groovy</groupId>
            <artifactId>groovy</artifactId>
            <version>3.0.9</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.codehaus.gmavenplus</groupId>
                <artifactId>gmavenplus-plugin</artifactId>
                <version>1.12.1</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>compile</goal>
                            <goal>compileTests</goal>
                        </goals>
                        <configuration>
                            <sources>
                                <source>
                                    <directory>src/main/groovy</directory>
                                    <includes>
                                        <include>**/*.groovy</include>
                                    </includes>
                                </source>
                            </sources>
                            <testSources>
                                <testSource>
                                    <directory>src/test/groovy</directory>
                                    <includes>
                                        <include>**/*.groovy</include>
                                    </includes>
                                </testSource>
                            </testSources>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>

</project>
EOL

# Create the build.gradle file
cat > $PROJECT_NAME/build.gradle <<EOL
plugins {
    id 'org.springframework.boot' version '$SPRING_BOOT_VERSION'
    id 'io.spring.dependency-management' version '1.1.0'
    id 'java'
    id 'groovy'
}

group = '$GROUP'
version = '$VERSION'
java {
	sourceCompatibility = '$JAVA_VERSION'
	targetCompatibility = '$JAVA_VERSION'
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.projectlombok:lombok'
    runtimeOnly 'com.h2database:h2'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    testImplementation 'org.spockframework:spock-core:2.3-groovy-3.0'
    testImplementation 'org.codehaus.groovy:groovy'
}

test {
    useJUnitPlatform()
}

tasks.withType(JavaCompile) {
    options.encoding = 'UTF-8'
}
EOL

# Create the settings.gradle file
cat > $PROJECT_NAME/settings.gradle <<EOL
rootProject.name = '$PROJECT_NAME'
EOL

# Create the main class file DemoApplication.java
cat > $PROJECT_NAME/src/main/java/com/example/demo/DemoApplication.java <<EOL
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
EOL

# Create the application.properties file
cat > $PROJECT_NAME/src/main/resources/application.properties <<EOL
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.h2.console.enabled=true
spring.jpa.hibernate.ddl-auto=update
EOL

# Create the application-test.properties file
mkdir -p $PROJECT_NAME/src/test/resources
cat > $PROJECT_NAME/src/test/resources/application-test.properties <<EOL
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.h2.console.enabled=true
spring.jpa.hibernate.ddl-auto=create-drop
EOL

# Create the controller file HelloController.java
cat > $PROJECT_NAME/src/main/java/com/example/demo/HelloController.java <<EOL
package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {

    @GetMapping("/")
    public String hello(Model model) {
        model.addAttribute("message", "Hello, Thymeleaf!");
        return "hello";
    }
}
EOL

# Create Thymeleaf template file hello.html
cat > $PROJECT_NAME/src/main/resources/templates/hello.html <<EOL
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Hello</title>
</head>
<body>
    <h1 th:text="\${message}">Hello, Thymeleaf!</h1>
</body>
</html>
EOL

# Creating the Java Test File SampleTest.java
cat > $PROJECT_NAME/src/test/java/com/example/demo/SampleTest.java <<EOL
package com.example.demo;

import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.test.context.ActiveProfiles;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@ActiveProfiles("test")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class SampleTest {

    @BeforeAll
    static void setupSpec() {
        System.out.println("Initialization that is performed only once in the entire test class.");
    }

    @BeforeEach
    void setup() {
        System.out.println("Initialization before each test method is executed.");
        System.out.println("Preparation for object creation, data initialization, etc. (given is an alias of setup)");
        System.out.println("given must be used in the setup method.");
    }

    @AfterEach
    void cleanup() {
        System.out.println("Cleanup after each test method is executed.");
    }

    @AfterAll
    static void cleanupSpec() {
        System.out.println("A cleanup that is performed only once in the entire test class.");
    }

    @Test
    @Order(1)
    void someTestMethod() {
        System.out.println("Preparation for object creation, data initialization, etc.");
        System.out.println("Some initialization");

        System.out.println("Execute test objectives");
        System.out.println("certain conditions");

        System.out.println("Verify the result after when is executed");
        System.out.println("Checking the number of mock method calls, etc.");

        System.out.println("Simultaneous execution of test objectives and validation results");
        System.out.println("Some expected results");

        System.out.println("Post-processing work such as deleting data created during testing");
        System.out.println("Post-processing (if any)");
    }

    @Test
    @Order(2)
    void onePlusOneShouldEqualTwo() {
        assertEquals(2, 1 + 1);
    }

    @Test
    @Order(3)
    void shouldBeAbleToRemoveElementsFromList() {
        List<Integer> list = new ArrayList<>(List.of(1, 2, 3, 4));
        list.remove(0);
        assertEquals(List.of(2, 3, 4), list);
    }

    @Test
    @Order(4)
    void shouldGetIndexOutOfBoundsExceptionWhenRemovingNonExistentElement() {
        List<Integer> list = new ArrayList<>(List.of(1, 2, 3, 4));
        assertThrows(IndexOutOfBoundsException.class, () -> list.remove(20));
        assertEquals(4, list.size());
    }

    @ParameterizedTest
    @MethodSource("provideNumbersForSquareCalculation")
    @Order(5)
    void calculateTheSquareOfANumber(int a, int b, int c) {
        assertEquals(c, Math.pow(a, b));
    }

    private static List<Arguments> provideNumbersForSquareCalculation() {
        return List.of(
                Arguments.of(1, 2, 1),
                Arguments.of(2, 2, 4),
                Arguments.of(3, 2, 9)
        );
    }
}
EOL

# Creating the Groovy Test File SampleSpec.groovy
cat > $PROJECT_NAME/src/test/groovy/com/example/demo/SampleSpec.groovy <<EOL
package com.example.demo

import org.springframework.test.context.ActiveProfiles
import spock.lang.Specification
import spock.lang.Unroll

@ActiveProfiles("test")
@Unroll
class SampleSpec extends Specification {

    def setupSpec() {
        println("Initialization executed once in the entire test class.")
    }

    def setup() {
        println("Initialization before each test method execution.")
        given:
        println("Preparation work such as object creation and data initialization. (given is an alias for setup)")
        println("given must be used in the setup method.")
    }

    def cleanup() {
        println("Cleanup work after each test method execution.")
    }

    def cleanupSpec() {
        println("Cleanup work executed once in the entire test class.")
    }

    def "some test method"() {
        // setup: or given:
        setup:
        println("Preparation work such as object creation and data initialization.")
        println("Some initialization")

        when:
        println("Execute test target")
        println("Some conditions")

        then:
        println("Verify the result after executing when")
        println("Check the number of times the mock method is called, etc.")

        expect:
        println("Execute the test target and verify the result simultaneously")
        println("Some expected results")

        cleanup:
        println("Post-processing work such as deleting data created during the test")
        println("Post-processing (if any)")
    }

    def "one plus one should equal two"() {
        expect:
        1 + 1 == 2
    }

    def "should be able to remove elements from the list"() {
        given:
        def list = [1, 2, 3, 4]

        when:
        list.remove(0)

        then:
        list == [2, 3, 4]
    }

    def "should get an index out of bounds exception when removing a non-existent element"() {
        given:
        def list = [1, 2, 3, 4]

        when:
        list.remove(20)

        then:
        thrown(IndexOutOfBoundsException)
        list.size() == 4
    }

    def "calculate the square of a number"(int a, int b, int c) {
        expect:
        Math.pow(a, b) == c

        where:
        a | b | c
        1 | 2 | 1
        2 | 2 | 4
        3 | 2 | 9
    }
}
EOL

echo "Project $PROJECT_NAME created successfully!"