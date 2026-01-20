# 🚀 Guide de Démarrage Rapide

## Démarrer l'application

### Option 1: Utiliser le script batch (Windows)
Double-cliquez sur `start-docker.bat` ou exécutez dans PowerShell :
```powershell
.\start-docker.bat
```

### Option 2: Ligne de commande Docker
```powershell
docker-compose up --build
```

## Accéder à l'application

Une fois les containers démarrés (patientez 1-2 minutes pour le déploiement complet) :

- **Interface Web**: http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
- **Console Admin Payara**: http://localhost:4848 (admin/admin)
- **Base de données MySQL**: localhost:3307 (root/root)

## Arrêter l'application

### Option 1: Script batch
Double-cliquez sur `stop-docker.bat`

### Option 2: Ligne de commande
```powershell
docker-compose down
```

## Tester l'API REST

Après le démarrage, exécutez le script de test :
```powershell
.\test-api.ps1
```

## Résolution des problèmes courants

### Le port 8080 est déjà utilisé
Modifiez `docker-compose.yml` ligne 20 :
```yaml
ports:
  - "9090:8080"  # Changez 8080 en 9090 ou autre port libre
```

### Les containers ne démarrent pas
Nettoyez et reconstruisez :
```powershell
docker-compose down -v
docker-compose up --build
```

### Voir les logs en direct
```powershell
docker-compose logs -f app
```

## Fonctionnalités de l'interface Web

1. **Onglet Students**: Ajouter, voir, et supprimer des étudiants
2. **Onglet Companies**: Gérer les entreprises
3. **Onglet Internships**: Créer des affectations de stages entre étudiants et entreprises

## API REST Endpoints

Base URL: `http://localhost:8080/Internship_Management-1.0-SNAPSHOT/api`

### Students
- `GET /students` - Liste tous les étudiants
- `POST /students` - Créer un étudiant
- `DELETE /students/{id}` - Supprimer un étudiant

### Companies
- `GET /companies` - Liste toutes les entreprises
- `POST /companies` - Créer une entreprise
- `DELETE /companies/{id}` - Supprimer une entreprise

### Internships
- `GET /internships` - Liste tous les stages
- `POST /internships` - Créer un stage
- `DELETE /internships/{id}` - Supprimer un stage

## Structure du projet

```
src/
├── main/
│   ├── java/com/example/internship_management/
│   │   ├── entity/          # Entités JPA
│   │   ├── dao/             # Accès aux données
│   │   ├── service/         # Logique métier
│   │   └── rest/            # API REST
│   ├── resources/
│   │   └── META-INF/        # Configuration JPA
│   └── webapp/
│       └── index.html       # Interface utilisateur
```

## Technologies utilisées

- Jakarta EE 10
- Payara Server 6
- MySQL 8.0
- Hibernate/JPA
- JAX-RS
- Docker & Docker Compose
