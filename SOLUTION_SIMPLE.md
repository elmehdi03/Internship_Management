# SOLUTION SIMPLE - DÉMARRAGE RAPIDE

## 🚀 ÉTAPES RAPIDES (3 minutes max)

### Étape 1 : Ouvrir PowerShell en Administrateur
1. Appuyez sur `Windows + X`
2. Cliquez sur "Windows PowerShell (Admin)"

### Étape 2 : Exécuter ces 3 commandes

```powershell
cd "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"

docker-compose down -v

docker-compose up --build -d
```

### Étape 3 : Attendre 30 secondes puis vérifier

```powershell
docker-compose logs app
```

Vous devriez voir : "Waiting for domain1 to start" puis "domain1 started"

### Étape 4 : Tester l'accès

Ouvrez votre navigateur et allez sur :
```
http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
```

## ✅ SI ÇA MARCHE PAS

### Test 1 : Vérifier que les containers tournent
```powershell
docker ps
```
Vous devez voir 2 containers : `app-1` et `db-1`

### Test 2 : Voir les logs en direct
```powershell
docker-compose logs -f app
```
Appuyez sur `Ctrl+C` pour sortir

### Test 3 : Tester avec une page simple
```
http://localhost:8080/Internship_Management-1.0-SNAPSHOT/test.html
```

## 🔥 DERNIER RECOURS - TOUT NETTOYER

Si vraiment rien ne marche :

```powershell
cd "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"

# Tout arrêter
docker-compose down -v

# Supprimer l'image
docker rmi internship_management-app

# Reconstruire proprement
docker-compose build --no-cache

# Démarrer
docker-compose up -d

# Voir les logs
docker-compose logs -f app
```

## 📱 URLS À TESTER

Une fois démarré, testez ces URLs dans l'ordre :

1. **Test serveur** : http://localhost:8080/
2. **Test app** : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
3. **Test simple** : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/test.html
4. **API REST** : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/api/students

## ⏱️ PATIENCE

- Le build prend ~30 secondes
- Le démarrage de Payara prend ~20-30 secondes
- Le déploiement de l'app prend ~10 secondes

**TOTAL : Environ 1 minute après `docker-compose up`**

## 💡 ASTUCE

Si vous voyez "404 Not Found" :
- C'est normal si l'app n'est pas encore déployée
- Attendez 30 secondes de plus
- Rechargez la page

Si vous voyez "502 Bad Gateway" :
- Payara n'a pas encore démarré
- Attendez 20 secondes
- Rechargez la page

Si vous voyez "Connection refused" :
- Le container n'est pas démarré
- Vérifiez avec `docker ps`
