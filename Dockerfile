FROM tomcat:jdk11-openjdk-slim

MAINTAINER barath147

COPY target/hello-app-play-k8s-*.war /usr/local/tomcat/webapps/hello-app.war