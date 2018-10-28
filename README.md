# Kubernetes Hello World
This is to demo the containerization of Spring Boot application to Docker and Kubernetes.

## Before you begin
You will need the following tools installed on your machine
* [OpenJDK](https://openjdk.java.net/install/) or
  [OracleJDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html) 1.8
* [Maven 3.5.x](http://maven.apache.org/download.cgi)
* [Docker CE](https://docs.docker.com/install/)
* [Kubectl and Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)

## Containerizing the Spring Boot demo application
You can go to [Spring Initializer](https://start.spring.io/) to generate a demo 
application or use this git project. This demo include a REST endpoint 
[\/hello](http://localhost:8080/hello) to echo a message with current timestamp.

### Building the Spring Boot Application
To generate the artifacts:
``` bash
mvn clean packge
```

You can check in the directory target for a jar file name helloworld.jar

### Building the Docker Image
Ensure that the Docker is running on your machine. To check if it's running:
```bash
docker info
```

To build the docker image:
```bash
mvn dockerfile:build
```

To validate if the docker image has been created:
```bash
docker images
```

And you should see output like this:
```bash
REPOSITORY                          TAG                 IMAGE ID            CREATED             SIZE
jeejeejango/springboot-helloworld   0.0.1-SNAPSHOT      c0a9c2628088        4 seconds ago       99.3MB
openjdk                             8-jre-alpine        2e01f547f003        3 days ago          83MB
```

### Running the Docker image
To run the helloworld images, run the following command:
```bash
docker run -d -p 8080:8080 helloworld
```

You can validate if a container is created successfully and running:
```bash
docker ps
``` 
Output (Note that container_id and name will be different on your machine):
```bash
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                    NAMES
7ee618bd6deb        helloworld          "java -Djava.securit…"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp   admiring_volhard
```

### Testing the Container 
if the container is running well, you can open a browser and point to the url: http://<docker_machine_ip>:8080/hello

To get the docker-machine IP:
```bash
docker-machine ip
```

You can also testing with curl if available:
```bash
curl http://<docker_machine_ip>:8080/hello
```

## Kubernetes
//todo