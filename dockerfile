FROM gradle:7.5.1-jdk11-alpine AS build

COPY --chown=gradle:gradle . /home/gradle/src

USER root

RUN chown -R gradle /home/gradle/src

WORKDIR /home/gradle/src

RUN gradle build --scan

RUN echo $(ls /home/gradle/src/build/libs/)


FROM openjdk:17.0.1-jdk-slim

EXPOSE 8080

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/demo-0.0.1-SNAPSHOT.jar /app/spring-boot-application.jar

CMD ["java","-jar", "/app/spring-boot-application.jar"]