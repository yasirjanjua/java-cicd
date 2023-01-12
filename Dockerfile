FROM maven:3.6.3-openjdk-17 AS BUILDER

COPY pom.xml /tmp/
COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package -X

FROM openjdk:17-alpine

COPY --from=BUILDER /tmp/target/java-cicd*.jar /java-cicd.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-Djava.security.egd=file:/dev/./urandom","-jar","/java-cicd.jar"]
