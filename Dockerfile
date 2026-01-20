# Build stage
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM payara/server-full:6.2024.10-jdk17

# Copier le WAR (le driver MySQL est déjà dedans)
COPY --from=builder /app/target/*.war ${PAYARA_DIR}/glassfish/domains/domain1/autodeploy/app.war


EXPOSE 8080 4848

