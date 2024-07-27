FROM alpine/git as clone
# MAINTAINER pprasad<perlaprasad4@gmail.com>
WORKDIR /app
RUN git clone https://github.com/prasadperla55/boxfuse.git
# stage-two
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone  /app/boxfuse  /app
RUN mvn package
# stage-third
FROM tomcat:7-jre7

ADD tomcat-users.xml /usr/local/tomcat/conf
COPY --from=build /app/target/hello-1.0.war /usr/local/tomcat/webapps
