# 🚀 Instructions de Démarrage - Internship Management

## Option 1 : Utiliser le fichier BAT (RECOMMANDÉ)

1. Ouvrez l'Explorateur Windows
2. Naviguez vers : `C:\Users\ROG STRIX\IdeaProjects\Internship_Management`
3. Double-cliquez sur **`start-docker.bat`**
4. Une fenêtre de commande s'ouvrira et démarrera l'application

## Option 2 : Utiliser PowerShell

1. Ouvrez PowerShell
2. Exécutez les commandes suivantes :

```powershell
cd "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"
docker-compose up --build
```

## Option 3 : Mode détaché (en arrière-plan)

```powershell
cd "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"
docker-compose up --build -d
```

## ⏱️ Temps de démarrage

- **Première fois** : ~2-3 minutes (construction des images)
- **Démarrages suivants** : ~30-60 secondes

## 📊 Vérifier que tout fonctionne

### 1. Vérifier les containers
```powershell
docker-compose ps
```

Vous devriez voir :
- `internship_management-db-1` - Status: Up (healthy)
- `internship_management-app-1` - Status: Up

### 2. Voir les logs
```powershell
docker-compose logs -f app
```

Attendez de voir :
```
✓ Payara démarré avec succès!
✓ Application disponible sur http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
```

### 3. Accéder à l'application

Ouvrez votre navigateur :
- **Interface Web** : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
- **Console Admin Payara** : http://localhost:4848

## 🧪 Tester l'API REST

Après le démarrage, testez l'API :

```powershell
# Depuis le dossier du projet
.\test-api.ps1
```

Ou manuellement avec PowerShell :

```powershell
# Obtenir tous les étudiants
Invoke-RestMethod -Uri "http://localhost:8080/Internship_Management-1.0-SNAPSHOT/api/students" -Method GET

# Créer un étudiant
$student = @{name="John Doe"; email="john@test.com"; major="Computer Science"} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8080/Internship_Management-1.0-SNAPSHOT/api/students" -Method POST -Body $student -ContentType "application/json"
```

## 🛑 Arrêter l'application

### Option 1 : Double-cliquez sur `stop-docker.bat`

### Option 2 : PowerShell
```powershell
cd "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"
docker-compose down
```

## 🔧 En cas de problème

### Les ports sont déjà utilisés
Modifiez `docker-compose.yml` :
```yaml
ports:
  - "9090:8080"  # Changez le premier port
```

### Nettoyer complètement et redémarrer
```powershell
cd "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"
docker-compose down -v
docker-compose up --build
```

### Voir les logs en temps réel
```powershell
docker-compose logs -f
```

### L'application ne démarre pas
1. Vérifiez que Docker Desktop est en cours d'exécution
2. Vérifiez les logs : `docker-compose logs app`
3. Vérifiez que les ports 8080 et 3307 sont libres

## 📱 Fonctionnalités de l'interface Web

Une fois l'application démarrée, vous pouvez :

1. **Gérer les Étudiants** (Onglet Students)
   - Ajouter un étudiant avec nom, email et filière
   - Voir la liste de tous les étudiants
   - Supprimer des étudiants

2. **Gérer les Entreprises** (Onglet Companies)
   - Ajouter une entreprise avec nom, secteur et localisation
   - Voir la liste de toutes les entreprises
   - Supprimer des entreprises

3. **Gérer les Stages** (Onglet Internships)
   - Créer un stage en associant un étudiant à une entreprise
   - Définir le poste, dates de début et fin
   - Voir tous les stages
   - Supprimer des stages

## 🎯 Prochaines étapes

1. Démarrez l'application
2. Ouvrez http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
3. Ajoutez quelques étudiants et entreprises
4. Créez des stages
5. Testez l'API REST avec `.\test-api.ps1`

---

**Besoin d'aide ?** Consultez le fichier README.md pour plus de détails.
