#
# Build stage
#
FROM maven:3.9.9-openjdk-17-slim AS build

COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml dependency:resolve

COPY src /home/app/src
RUN mvn -f /home/app/pom.xml clean package -DskipTests

#
# Package stage
#
FROM openjdk:17-slim
COPY --from=build /home/app/target/HomeworkFourAtlas-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/demo.jar"]
