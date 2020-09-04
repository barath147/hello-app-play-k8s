FROM openjdk:11-jdk-slim

MAINTAINER barath147

COPY target/hello-app-play-k8s-*.jar hello-app.jar

ENTRYPOINT ["java","-jar","/hello-app.jar"]