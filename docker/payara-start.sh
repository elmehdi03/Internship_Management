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

# Démarrer Payara
echo "Démarrage de Payara Server..."
${PAYARA_DIR}/bin/asadmin start-domain

echo "✓ Payara démarré avec succès!"
echo "✓ Application disponible sur http://localhost:8080/Internship_Management-1.0-SNAPSHOT/"
echo "L'application se déploie automatiquement via autodeploy..."

# Garder le processus en vie en suivant les logs
tail -f ${PAYARA_DIR}/glassfish/domains/domain1/logs/server.log
