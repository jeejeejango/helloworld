# Spring Boot sample with Docker and Kubernetes
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
To build the artifacts:
``` bash
mvn clean compile
```

You can check in the directory target for a jar file name helloworld.jar

### Building the Docker Image
Ensure that the Docker is running on your machine. To check if it's running:
```bash
docker info
```

[jib-maven-plugin](https://github.com/GoogleContainerTools/jib/tree/master/jib-maven-plugin)
will build the docker image to daemon without the Dockerfile:
```bash
mvn jib:dockerBuild
```

To validate if the docker image has been created:
```bash
docker images
```

And you should see output like this:
```bash
REPOSITORY                          TAG                 IMAGE ID            CREATED             SIZE
jeejeejango/springboot-helloworld   latest              1113bae41761        20 seconds ago      99.2MB
openjdk                             8-jre-alpine        2e01f547f003        4 days ago          83MB
```

### Running the Docker image
To run the helloworld images, run the following command:
```bash
docker run -d -p 8080:8080 jeejeejango/springboot-helloworld
```

You can validate if a container is created successfully and running:
```bash
docker ps
``` 
Output (Note that container_id and name will be different on your machine):
```bash
CONTAINER ID        IMAGE                               COMMAND                  CREATED              STATUS              PORTS                    NAMES
8d037fa20ad7        jeejeejango/springboot-helloworld   "java -cp /app/resou…"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp   suspicious_nightingale
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

### Deployment image to Registry
To deploy image to  Registry:
```bash
mvn compile jib:build
```
Note: You will need to login to Docker Hub using `docker login`. You will need to change 
to your docker registry username in the pom file.

### Deployment image to OCI Registry (OCIR)
You can also deploy the docker image to OCI Registry. Please refer to the tutorial 
[here](https://www.oracle.com/webfolder/technetwork/tutorials/obe/oci/registry/index.html).

## Kubernetes/Minikube
After deploying the docker image to the registry, you can now deploy this image on minikube.
Check if  minikube is up and running using `minikube status`. To deploy this to minikube:
```bash
kubectl apply -f deploy/kubernetes
```

This will apply the deployment and service configuration to minikube. Check if the pods 
are running using `kubectl get po` and you can check the results:
```bash
NAME                                    READY   STATUS    RESTARTS   AGE
springboot-helloworld-f7fd5974f-npprb   1/1     Running   0          6m
springboot-helloworld-f7fd5974f-p577n   1/1     Running   0          6m
```

Now you can check if the service is running using `kubectl get svc` and validate the 
results:
```bash
NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
springboot-helloworld   NodePort    10.102.204.239   <none>        8080:31355/TCP   7m
```

To run the service, you can run `minikube service springboot-helloworld` and a new 
browser will be launched. Ensure endpoint `/hello` is added to the url.

You can also run `minikube dashboard` to launch the Kubernetes dashboard.

## Kubernetes/OKE
The steps for deployment to 
[OKE](https://docs.cloud.oracle.com/iaas/Content/ContEng/Concepts/contengoverview.htm) 
is the same. Please refer to the terraform script
 [here](https://github.com/jeejeejango/terraform-oci-scripts/tree/master/oke-cluster) 
for the installation. You will need to download the kubeconfig from OKE.

