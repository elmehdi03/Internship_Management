#!/bin/sh

echo "=== Starting Data Generator ==="

# Attendre que WildFly soit complètement démarré
echo "Waiting for WildFly to be ready..."
sleep 20

# Télécharger le driver MySQL JDBC
echo "Downloading MySQL JDBC driver..."
curl -L -o /tmp/mysql-connector-j-8.3.0.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar

# Compiler et exécuter le générateur de données
echo "Compiling DataGenerator..."
javac -cp /tmp/mysql-connector-j-8.3.0.jar /app/DataGenerator.java

echo "Running DataGenerator..."
java -cp /tmp/mysql-connector-j-8.3.0.jar:/app DataGenerator

echo "=== Data Generation Complete ==="

