# Build stage
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Download MySQL driver in the builder stage
RUN mvn dependency:copy -Dartifact=com.mysql:mysql-connector-j:8.3.0 -DoutputDirectory=/app/jdbc-driver

# Runtime stage - Using TomEE 10 (Jakarta EE 10)
FROM tomee:10-jre17-plume

# Remove default webapps
RUN rm -rf /usr/local/tomee/webapps/*

# Copy MySQL JDBC driver to TomEE lib
COPY --from=builder /app/jdbc-driver/*.jar /usr/local/tomee/lib/

# Copy the WAR to webapps
COPY --from=builder /app/target/*.war /usr/local/tomee/webapps/Internship_Management-1.0-SNAPSHOT.war

EXPOSE 8080


