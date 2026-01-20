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

# Démarrer Payara en arrière-plan
echo "Démarrage de Payara Server..."
${PAYARA_DIR}/bin/asadmin start-domain --verbose=false &
PAYARA_PID=$!

# Attendre que Payara soit prêt
echo "Attente du démarrage de Payara..."
sleep 15

# Créer un fichier de mot de passe pour asadmin
echo "AS_ADMIN_PASSWORD=" > /tmp/pwdfile
chmod 600 /tmp/pwdfile

# Créer le pool de connexion JDBC
echo "Configuration du pool de connexion MySQL..."
${PAYARA_DIR}/bin/asadmin --user admin --passwordfile /tmp/pwdfile --host localhost --port 4848 create-jdbc-connection-pool \
    --datasourceclassname com.mysql.cj.jdbc.MysqlDataSource \
    --restype javax.sql.DataSource \
    --property "serverName=${DB_HOST}:portNumber=${DB_PORT}:databaseName=${DB_NAME}:user=${DB_USER}:password=${DB_PASSWORD}:useSSL=false:allowPublicKeyRetrieval=true:serverTimezone=UTC" \
    InternshipPool 2>/dev/null || echo "Pool déjà existant"

# Créer la ressource JDBC
echo "Configuration de la ressource JDBC..."
${PAYARA_DIR}/bin/asadmin --user admin --passwordfile /tmp/pwdfile --host localhost --port 4848 create-jdbc-resource \
    --connectionpoolid InternshipPool \
    java:jboss/datasources/InternshipDS 2>/dev/null || echo "Ressource déjà existante"

# Ping le pool pour vérifier la connexion
echo "Test de la connexion à la base de données..."
if ${PAYARA_DIR}/bin/asadmin --user admin --passwordfile /tmp/pwdfile --host localhost --port 4848 ping-connection-pool InternshipPool 2>/dev/null; then
    echo "✓ Connexion MySQL réussie!"
else
    echo "⚠ Test de connexion a échoué mais continue..."
fi

echo "✓ Configuration terminée avec succès!"

# Déployer le WAR explicitement
echo "Déploiement de l'application..."
${PAYARA_DIR}/bin/asadmin --user admin --passwordfile /tmp/pwdfile --host localhost --port 4848 deploy \
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

# Nettoyer le fichier de mot de passe
rm -f /tmp/pwdfile

# Garder Payara en avant-plan
echo "Payara fonctionne en mode production..."
wait $PAYARA_PID

