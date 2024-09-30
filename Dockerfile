FROM maven:3.8.6-openjdk-17-slim AS build
WORKDIR /home/app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-slim
COPY --from=build /home/app/target/HomeworkFourAtlas-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
ENTRYPOINT ["java", "-jar", "/usr/local/lib/demo.jar"]

