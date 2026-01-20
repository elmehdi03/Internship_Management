#!/bin/bash
set -e

echo "=== Démarrage de Payara Server pour Internship Management ==="

# Attendre que MySQL soit disponible
echo "Attente de la disponibilité de MySQL..."
max_tries=30
count=0

while [ $count -lt $max_tries ]; do
    if (echo > /dev/tcp/$DB_HOST/$DB_PORT) 2>/dev/null; then
        echo "✓ MySQL est prêt!"
        sleep 2
        break
    fi
    count=$((count+1))
    echo "Tentative $count/$max_tries..."
    sleep 2
done

if [ $count -eq $max_tries ]; then
    echo "ERREUR: Impossible de se connecter à MySQL après $max_tries tentatives"
    exit 1
fi

# Create password file for asadmin
echo "AS_ADMIN_PASSWORD=" > /tmp/pwdfile
echo "AS_ADMIN_NEWPASSWORD=" >> /tmp/pwdfile

# Démarrer Payara en arrière-plan
echo "Démarrage de Payara Server..."
${PAYARA_DIR}/bin/asadmin start-domain &
PAYARA_PID=$!

# Attendre que Payara soit prêt (check list-domains command)
echo "Attente du démarrage de Payara..."
max_wait=60
wait_count=0
while [ $wait_count -lt $max_wait ]; do
    if ${PAYARA_DIR}/bin/asadmin --passwordfile=/tmp/pwdfile list-domains 2>/dev/null | grep -q "running"; then
        echo "✓ Payara est prêt!"
        break
    fi
    wait_count=$((wait_count+1))
    echo "Attente de Payara... $wait_count/$max_wait"
    sleep 2
done

# Additional wait for admin port to be fully ready
sleep 5

# Créer le pool de connexion JDBC
echo "Configuration du pool de connexion MySQL..."
${PAYARA_DIR}/bin/asadmin --passwordfile=/tmp/pwdfile create-jdbc-connection-pool \
    --datasourceclassname com.mysql.cj.jdbc.MysqlDataSource \
    --restype javax.sql.DataSource \
    --property "serverName=${DB_HOST}:portNumber=${DB_PORT}:databaseName=${DB_NAME}:user=${DB_USER}:password=${DB_PASSWORD}:useSSL=false:allowPublicKeyRetrieval=true:serverTimezone=UTC" \
    InternshipPool 2>/dev/null || echo "Pool déjà existant ou erreur"

# Créer la ressource JDBC avec le bon nom JNDI
echo "Configuration de la ressource JDBC..."
${PAYARA_DIR}/bin/asadmin --passwordfile=/tmp/pwdfile create-jdbc-resource \
    --connectionpoolid InternshipPool \
    jdbc/InternshipDS 2>/dev/null || echo "Ressource déjà existante ou erreur"

# Ping le pool pour vérifier la connexion
echo "Test de la connexion à la base de données..."
if ${PAYARA_DIR}/bin/asadmin --passwordfile=/tmp/pwdfile ping-connection-pool InternshipPool 2>/dev/null; then
    echo "✓ Connexion MySQL réussie!"
else
    echo "⚠ Test de connexion a échoué mais continue..."
fi

echo "✓ Configuration JDBC terminée!"

# Déployer le WAR explicitement
echo "Déploiement de l'application..."
${PAYARA_DIR}/bin/asadmin --passwordfile=/tmp/pwdfile deploy \
    --force \
    --name Internship_Management \
    --contextroot Internship_Management-1.0-SNAPSHOT \
    ${PAYARA_DIR}/glassfish/domains/domain1/autodeploy/Internship_Management-1.0-SNAPSHOT.war

if [ $? -eq 0 ]; then
    echo "✓ Application déployée avec succès!"
else
    echo "⚠ Erreur lors du déploiement"
fi

echo "✓ Application disponible sur http://localhost:8080/Internship_Management-1.0-SNAPSHOT/"

# Cleanup
rm -f /tmp/pwdfile

# Garder Payara en avant-plan
echo "Payara fonctionne en mode production..."
tail -f ${PAYARA_DIR}/glassfish/domains/domain1/logs/server.log
