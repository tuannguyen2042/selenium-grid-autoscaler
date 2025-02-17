#
# Build stage
#
FROM maven:3.6.3-adoptopenjdk-8 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM adoptopenjdk/openjdk8:alpine-slim
COPY --from=build /home/app/target/*.jar /usr/local/lib/grid-utils.jar

# Start with a base image containing Java runtime
#FROM adoptopenjdk/openjdk8:alpine-slim

# Add Maintainer Info
#LABEL maintainer="sahajamit@gmail.com"

#VOLUME /tmp

# The application's jar file
#ARG JAR_FILE=target/*.jar

#COPY ${JAR_FILE} app/grid-utils.jar

#WORKDIR app

# Run the jar file
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/usr/local/lib/grid-utils.jar"]
