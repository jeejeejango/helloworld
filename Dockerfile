FROM openjdk:8-jre-alpine
MAINTAINER jeejeejango <boonping.teo@gmail.com>

VOLUME /tmp
ARG JAR_FILE
COPY target/${JAR_FILE} app.jar

ENTRYPOINT ["java","-Djava.clssecurity.egd=file:/dev/./urandom","-jar","/app.jar"]

EXPOSE 8080