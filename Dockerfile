# syntax=docker/dockerfile:1.4
ARG BASE_IMAGE=redhat/ubi8-micro
ARG BASE_TAG=8.7
FROM gradle:7.4.2-jdk11 AS build
#FROM registry1.dso.mil/ironbank/opensource/gradle/gradle-jdk11:7.4.2 AS build
USER root
VOLUME /app
WORKDIR /app
COPY . .
RUN ./gradlew clean --build-cache assemble 

FROM ${BASE_IMAGE}:${BASE_TAG} AS docker

WORKDIR /app

# Create user / home directory for compliance
RUN echo "bigbang:x:1000:1000::/home/bigbang:/sbin/nologin" >> /etc/passwd \
    && mkdir -p /home/bigbang \
    && chmod 0750 /home/bigbang \
    && chown 1000:1000 /home/bigbang

COPY --from=build --link /app/build/libs/p1-keycloak-plugin-*.jar /app/p1-keycloak-plugin.jar
#COPY build/libs/p1-keycloak-plugin-*.jar /app/p1-keycloak-plugin.jar

RUN chmod +rx *.jar

USER 1000:1000

HEALTHCHECK NONE
