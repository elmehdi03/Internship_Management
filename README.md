# 🎓 Système de Gestion des Stages

Application web Jakarta EE pour la gestion des stages étudiants en entreprise.

## 🎯 Objectifs

- Gérer les étudiants, entreprises et stages
- Fournir une interface web intuitive
- Exposer une API REST pour l'intégration
- Assurer la persistance des données avec JPA/Hibernate

## 🚀 Démarrage rapide

**Lancer l'application :**
```bash
DEPLOYER.bat
```

Ou manuellement :
```bash
mvn clean package -DskipTests
docker-compose up --build -d
```

**Accès :**
- Application web : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
- API REST : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/api/students

## 🛠️ Stack technique

### Backend
- **Jakarta EE 10** - Framework d'entreprise
- **Hibernate 6.4** - ORM JPA
- **CDI** - Injection de dépendances
- **Bean Validation** - Validation des données
- **JAX-RS** - API REST

### Serveur d'application
- **TomEE 10 Plume** - Serveur Jakarta EE

### Base de données
- **MySQL 8.0** - SGBD relationnel
- **HikariCP** - Pool de connexions

### Build & Déploiement
- **Maven 3.9** - Gestion de projet
- **Docker & Docker Compose** - Conteneurisation

## 🏗️ Architecture

### Structure en couches

```
┌─────────────────────────────────────┐
│     Couche Présentation (Web)       │
│  - Servlets (students, companies)   │
│  - JSP (vues)                        │
│  - REST Resources                    │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Couche Service (Métier)        │
│  - StudentService                   │
│  - CompanyService                   │
│  - InternshipService                │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│     Couche DAO (Accès données)      │
│  - StudentDAO                       │
│  - CompanyDAO                       │
│  - InternshipDAO                    │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Base de données MySQL          │
│  - Tables : student, company,       │
│             internship              │
└─────────────────────────────────────┘
```

### Modèle de données

```
Student (1) ──── (N) Internship (N) ──── (1) Company
   │                     │                      │
   ├─ id                 ├─ id                  ├─ id
   ├─ firstName          ├─ title               ├─ name
   ├─ lastName           ├─ startDate           ├─ sector
   ├─ email              ├─ endDate             └─ city
   └─ promotion          ├─ description
                         ├─ student_id (FK)
                         └─ company_id (FK)
```

## 📂 Structure du projet

```
src/main/
├── java/.../internship_management/
│   ├── entity/              # Entités JPA (@Entity)
│   │   ├── Student.java
│   │   ├── Company.java
│   │   └── Internship.java
│   │
│   ├── dao/                 # Data Access Objects (@Stateless)
│   │   ├── GenericDAO.java
│   │   ├── StudentDAO.java
│   │   ├── CompanyDAO.java
│   │   └── InternshipDAO.java
│   │
│   ├── service/             # Services métier (@ApplicationScoped)
│   │   ├── StudentService.java
│   │   ├── CompanyService.java
│   │   └── InternshipService.java
│   │
│   ├── servlet/             # Servlets web (@WebServlet)
│   │   ├── StudentServlet.java
│   │   ├── CompanyServlet.java
│   │   └── InternshipServlet.java
│   │
│   └── rest/                # Endpoints REST (@Path)
│       ├── JaxRsActivator.java
│       ├── StudentResource.java
│       ├── CompanyResource.java
│       └── InternshipResource.java
│
├── resources/
│   ├── database.sql         # Script d'initialisation
│   └── META-INF/
│       └── persistence.xml  # Configuration JPA
│
└── webapp/
    ├── index.html           # Page d'accueil
    ├── students.jsp         # Liste des étudiants
    ├── companies.jsp        # Liste des entreprises
    ├── internships.jsp      # Liste des stages
    └── WEB-INF/
        ├── beans.xml        # Configuration CDI
        └── resources.xml    # DataSource
```

## 🔌 API REST

### Endpoints disponibles

**Students**
- `GET    /api/students` - Liste tous les étudiants
- `GET    /api/students/{id}` - Récupère un étudiant
- `POST   /api/students` - Crée un étudiant
- `PUT    /api/students/{id}` - Modifie un étudiant
- `DELETE /api/students/{id}` - Supprime un étudiant

**Companies**
- `GET    /api/companies` - Liste toutes les entreprises
- `GET    /api/companies/{id}` - Récupère une entreprise
- `POST   /api/companies` - Crée une entreprise
- `PUT    /api/companies/{id}` - Modifie une entreprise
- `DELETE /api/companies/{id}` - Supprime une entreprise

**Internships**
- `GET    /api/internships` - Liste tous les stages
- `GET    /api/internships/{id}` - Récupère un stage
- `POST   /api/internships` - Crée un stage
- `PUT    /api/internships/{id}` - Modifie un stage
- `DELETE /api/internships/{id}` - Supprime un stage

## 🧪 Données de test

L'application est livrée avec des données de test :
- **20 étudiants** (Master 1, Master 2, Licence 3)
- **15 entreprises** (divers secteurs)
- **30 stages** (6 mois chacun)

## 🔧 Commandes utiles

```bash
# Démarrer
docker-compose up -d

# Arrêter
docker-compose down

# Voir les logs
docker logs internship_management-app-1 -f

# Redémarrer avec nouvelle base
docker-compose down -v
docker-compose up --build -d

# Compiler
mvn clean package -DskipTests
```

## 📊 Technologies & Patterns

### Design Patterns utilisés
- **DAO Pattern** - Séparation de la logique d'accès aux données
- **Service Layer** - Encapsulation de la logique métier
- **Dependency Injection** - Couplage faible via CDI
- **Repository Pattern** - Abstraction de la persistance
- **MVC** - Séparation Model-View-Controller

### Annotations clés
- `@Entity` - Entités JPA
- `@Stateless` - EJB sans état
- `@ApplicationScoped` - Bean CDI singleton
- `@WebServlet` - Servlet HTTP
- `@Path` - Endpoint REST
- `@Transactional` - Gestion des transactions

## 🌐 Configuration

### Base de données (docker-compose.yml)
```yaml
MySQL 8.0
- Port : 3307
- Database : internship_management
- User : root
- Password : root
```

### Serveur d'application
```yaml
TomEE 10
- Port : 8080
- Context : /Internship_Management-1.0-SNAPSHOT
```

## 📝 Licence

Projet académique - Formation Jakarta EE

---

**Stack** : Jakarta EE 10 • Hibernate 6.4 • MySQL 8.0 • TomEE 10 • Docker

Application Jakarta EE 10 de gestion de stages avec JPA/Hibernate et MySQL, entièrement dockerisée.

> **🚀 Nouveau ici ?** Consultez le [Guide de Démarrage Rapide](QUICKSTART.md) pour lancer l'application en 2 minutes !

## 📋 Table des matières

- [Prérequis](#prérequis)
- [Architecture](#architecture)
- [Installation et Démarrage Rapide](#installation-et-démarrage-rapide)
- [Configuration](#configuration)
- [Utilisation](#utilisation)
- [Structure du Projet](#structure-du-projet)
- [Technologies Utilisées](#technologies-utilisées)
- [Gestion des Données](#gestion-des-données)
- [Commandes Docker Utiles](#commandes-docker-utiles)
- [Développement](#développement)
- [Dépannage](#dépannage)

## 🔧 Prérequis

- **Docker Desktop** (version 20.10+)
- **Docker Compose** (version 2.0+)
- **Windows** avec PowerShell
- Au moins **4 GB de RAM** disponible pour Docker
- **Ports libres** : 8080, 9990, 3306

### Installation de Docker Desktop

1. Téléchargez Docker Desktop depuis : https://www.docker.com/products/docker-desktop
2. Installez et démarrez Docker Desktop
3. Vérifiez l'installation avec : `docker --version` et `docker-compose --version`

## 🏗️ Architecture

L'application utilise une architecture microservices conteneurisée :

```
┌─────────────────────────────────────────────────┐
│                  start.bat                       │
│        (Orchestrateur de démarrage)              │
└────────────────────┬────────────────────────────┘
                     │
         ┌───────────┴───────────┐
         │   Docker Compose      │
         └───────────┬───────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
    ┌───▼──┐    ┌───▼──┐    ┌───▼────┐
    │MySQL │    │WildFly│   │DataGen │
    │:3306 │◄───┤:8080  │◄──┤        │
    └──────┘    └───────┘    └────────┘
```

### Services

1. **MySQL** : Base de données (mysql:8.0)
2. **WildFly** : Serveur d'applications Jakarta EE (31.0.0.Final-jdk17)
3. **Data Generator** : Génération automatique de données de test

## 🚀 Installation et Démarrage Rapide

### Méthode 1 : Double-clic (Recommandée)

1. Ouvrez le répertoire du projet
2. Double-cliquez sur **`start.bat`**
3. Attendez que l'application démarre (2-3 minutes la première fois)
4. Le navigateur s'ouvrira automatiquement sur l'application !

### Méthode 2 : Ligne de commande

```batch
cd C:\Users\ROG STRIX\IdeaProjects\Internship_Management
start.bat
```

### Première Exécution

La première fois, Docker va :
1. ✅ Télécharger les images de base (~2 GB)
2. ✅ Construire l'image de l'application
3. ✅ Démarrer MySQL et créer la base de données
4. ✅ Déployer l'application sur Payara Server
5. ✅ Générer automatiquement 65 enregistrements de test :
   - 20 étudiants
   - 15 entreprises
   - 30 stages

## ⚙️ Configuration

### Variables d'Environnement

Les variables sont définies dans `docker-compose.yml` :

```yaml
DB_HOST: mysql
DB_PORT: 3306
DB_NAME: internship_management
DB_USER: root
DB_PASSWORD: rootpassword
```

### Personnalisation

Pour modifier les identifiants MySQL, éditez `docker-compose.yml` :

```yaml
services:
  mysql:
    environment:
      MYSQL_ROOT_PASSWORD: votre_mot_de_passe
      MYSQL_DATABASE: votre_base
```

Et mettez à jour les variables correspondantes dans le service `wildfly`.

## 📱 Utilisation

### URLs d'Accès

| Service | URL | Description |
|---------|-----|-------------|
| **Application** | http://localhost:8080/Internship_Management-1.0-SNAPSHOT/ | Interface principale |
| **WildFly Console** | http://localhost:9990/ | Console d'administration |
| **MySQL** | localhost:3306 | Base de données (via client MySQL) |

### Connexion à MySQL

Utilisez un client MySQL (MySQL Workbench, DBeaver, etc.) :

```
Host: localhost
Port: 3306
Database: internship_management
User: root
Password: rootpassword
```

### API / Endpoints

L'application expose des services via CDI :

- **StudentService** : Gestion des étudiants
- **CompanyService** : Gestion des entreprises
- **InternshipService** : Gestion des stages

## 📂 Structure du Projet

```
Internship_Management/
├── docker/                          # Configuration Docker
│   ├── configure-wildfly.cli       # Configuration WildFly (DataSource)
│   ├── DataGenerator.java          # Générateur de données test
│   ├── init.sql                    # Initialisation base de données
│   ├── run-generator.sh            # Script d'exécution du générateur
│   ├── startup.sh                  # Script de démarrage WildFly
│   └── wait-for-it.sh              # Attente disponibilité service
├── src/
│   ├── main/
│   │   ├── java/com/example/internship_management/
│   │   │   ├── dao/                # Data Access Objects
│   │   │   │   ├── CompanyDAO.java
│   │   │   │   ├── InternshipDAO.java
│   │   │   │   └── StudentDAO.java
│   │   │   ├── entity/             # Entités JPA
│   │   │   │   ├── Company.java
│   │   │   │   ├── Internship.java
│   │   │   │   └── Student.java
│   │   │   └── service/            # Services métier
│   │   │       ├── CompanyService.java
│   │   │       ├── InternshipService.java
│   │   │       └── StudentService.java
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml  # Configuration JPA
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── beans.xml        # Configuration CDI
│   └── test/
├── Dockerfile                       # Image Docker de l'application
├── docker-compose.yml              # Orchestration des services
├── pom.xml                         # Configuration Maven
├── start.bat                       # Script de lancement (Windows)
├── stop.bat                        # Script d'arrêt (Windows)
└── README.md                       # Cette documentation
```

## 🛠️ Technologies Utilisées

| Technologie | Version | Description |
|------------|---------|-------------|
| **Java** | 17 | Langage de programmation |
| **Jakarta EE** | 10.0.0 | Plateforme entreprise |
| **Hibernate ORM** | 6.4.0.Final | Implémentation JPA |
| **MySQL** | 8.0 | Base de données |
| **WildFly** | 31.0.0.Final | Serveur d'applications |
| **Maven** | 3.9 | Gestion de build |
| **Docker** | 20.10+ | Conteneurisation |
| **Docker Compose** | 2.0+ | Orchestration |

### Dépendances Principales

```xml
<dependencies>
    <!-- Jakarta EE 10 API -->
    <dependency>
        <groupId>jakarta.platform</groupId>
        <artifactId>jakarta.jakartaee-api</artifactId>
        <version>10.0.0</version>
    </dependency>
    
    <!-- Hibernate ORM -->
    <dependency>
        <groupId>org.hibernate.orm</groupId>
        <artifactId>hibernate-core</artifactId>
        <version>6.4.0.Final</version>
    </dependency>
    
    <!-- MySQL JDBC Driver -->
    <dependency>
        <groupId>com.mysql</groupId>
        <artifactId>mysql-connector-j</artifactId>
        <version>8.3.0</version>
    </dependency>
</dependencies>
```

## 📊 Gestion des Données

### Génération Automatique

Au démarrage, le service `data-generator` crée automatiquement :

- **20 étudiants** avec noms, prénoms, emails uniques et promotions variées
- **15 entreprises** dans différents secteurs et villes
- **30 stages** assignant aléatoirement étudiants et entreprises

### Base de Données

Le schéma est créé automatiquement par Hibernate (`hibernate.hbm2ddl.auto=update`).

#### Tables créées :

1. **student** : Informations étudiants
   - id, first_name, last_name, email, promotion

2. **company** : Informations entreprises
   - id, name, sector, city

3. **internship** : Stages
   - id, title, start_date, end_date, description, student_id, company_id

### Persistance des Données

Les données sont stockées dans un volume Docker nommé `mysql_data` et persistent entre les redémarrages.

Pour repartir de zéro :
```batch
docker-compose down -v
```

## 🔍 Commandes Docker Utiles

### Démarrage / Arrêt

```batch
# Démarrer l'application
start.bat

# Arrêter les services (conserve les données)
stop.bat
# OU
docker-compose down

# Arrêter et supprimer les volumes (efface les données)
docker-compose down -v

# Redémarrer un service spécifique
docker-compose restart wildfly
```

### Logs et Debugging

```batch
# Voir tous les logs
docker-compose logs -f

# Logs d'un service spécifique
docker-compose logs -f wildfly
docker-compose logs -f mysql

# Logs depuis un certain temps
docker-compose logs --tail=100 wildfly
```

### Inspection

```batch
# Lister les conteneurs en cours
docker ps

# État des services
docker-compose ps

# Entrer dans un conteneur
docker exec -it internship_wildfly bash
docker exec -it internship_mysql bash

# Vérifier les ressources utilisées
docker stats
```

### Rebuild

```batch
# Reconstruire les images
docker-compose build --no-cache

# Reconstruire et redémarrer
docker-compose up -d --build
```

## 👨‍💻 Développement

### Modifier le Code

1. Éditez les fichiers sources dans `src/main/java`
2. Arrêtez l'application : `docker-compose down`
3. Reconstruisez : `docker-compose build`
4. Redémarrez : `docker-compose up -d`

Ou utilisez `start.bat` qui reconstruit automatiquement.

### Mode Développement avec Hot Reload

Pour activer le hot reload sans Docker :

1. Configurez votre IDE (IntelliJ IDEA / Eclipse)
2. Installez MySQL localement ou gardez le conteneur MySQL
3. Modifiez `persistence.xml` pour pointer vers `localhost:3306`
4. Déployez sur un serveur Payara local

### Tests

```batch
# Exécuter les tests unitaires
mvn test

# Build complet avec tests
mvn clean install
```

## 🐛 Dépannage

### Problème : Docker n'est pas reconnu

**Solution** : Installez Docker Desktop et vérifiez qu'il est dans le PATH.

### Problème : Port 8080 déjà utilisé

**Solution** : 
```batch
# Arrêter le service utilisant le port
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Ou changer le port dans docker-compose.yml
ports:
  - "8081:8080"  # Utilise 8081 au lieu de 8080
```

### Problème : L'application ne démarre pas

**Solutions** :
1. Vérifiez les logs : `docker-compose logs -f`
2. Vérifiez que tous les services sont up : `docker-compose ps`
3. Augmentez la mémoire allouée à Docker (Settings > Resources)
4. Redémarrez Docker Desktop
5. Supprimez les volumes et recommencez : `docker-compose down -v`

### Problème : Erreur de connexion à MySQL

**Solutions** :
1. Attendez 30 secondes de plus (MySQL peut être lent à démarrer)
2. Vérifiez le statut : `docker-compose logs mysql`
3. Vérifiez la santé : `docker inspect internship_mysql | findstr Health`

### Problème : Page blanche / 404

**Solutions** :
1. Vérifiez l'URL correcte : `http://localhost:8080/Internship_Management-1.0-SNAPSHOT/`
2. Vérifiez les logs WildFly : `docker-compose logs wildfly`
3. Vérifiez que le WAR est déployé : `docker exec internship_wildfly ls /opt/jboss/wildfly/standalone/deployments/`

### Problème : Build Maven échoue

**Solutions** :
1. Nettoyez le cache : `docker system prune -a`
2. Vérifiez la connexion Internet (Maven télécharge des dépendances)
3. Reconstruisez sans cache : `docker-compose build --no-cache`

### Réinitialisation Complète

Si tout échoue, réinitialisez complètement :

```batch
# Arrêter tous les conteneurs
docker-compose down -v

# Supprimer les images
docker rmi internship_management-wildfly

# Nettoyer Docker
docker system prune -a

# Redémarrer
start.bat
```

## 📝 Notes Importantes

- ⏱️ La première exécution prend 3-5 minutes (téléchargement des images)
- 💾 Les données persistent entre les redémarrages (volume Docker)
- 🔄 Les exécutions suivantes démarrent en ~30 secondes
- 🌐 L'application ouvre automatiquement le navigateur
- 📊 Les données de test sont générées automatiquement
- 🔒 N'utilisez pas ces identifiants en production !

## 📧 Support

Pour toute question ou problème :
1. Consultez la section [Dépannage](#dépannage)
2. Vérifiez les logs : `docker-compose logs -f`
3. Consultez la documentation officielle :
   - [Docker](https://docs.docker.com/)
   - [WildFly](https://docs.wildfly.org/)
   - [Jakarta EE](https://jakarta.ee/)

## 📄 Licence

Ce projet est un exemple éducatif pour la gestion des stages étudiants.

---

**Développé avec ❤️ pour la gestion des stages**

*Dernière mise à jour : Janvier 2026*

