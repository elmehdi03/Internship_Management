@echo off
REM Script de lancement de l'application Internship Management avec Docker

echo =====================================
echo Internship Management Application
echo =====================================
echo.

REM Vérifier si Docker est installé
docker --version >nul 2>&1
if errorlevel 1 (
    echo ERREUR: Docker n'est pas installé ou n'est pas dans le PATH.
    echo Veuillez installer Docker Desktop depuis https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

REM Vérifier si Docker est en cours d'exécution
docker info >nul 2>&1
if errorlevel 1 (
    echo ERREUR: Docker n'est pas en cours d'exécution.
    echo Veuillez démarrer Docker Desktop et réessayer.
    pause
    exit /b 1
)

echo [1/4] Nettoyage des conteneurs précédents...
docker-compose down -v 2>nul

echo.
echo [2/4] Construction de l'image Docker...
docker-compose build

if errorlevel 1 (
    echo ERREUR: La construction de l'image a échoué.
    pause
    exit /b 1
)

echo.
echo [3/4] Démarrage des services...
echo - MySQL Database
echo - Payara Application Server
echo - Data Generator
echo.
docker-compose up -d

if errorlevel 1 (
    echo ERREUR: Le démarrage des services a échoué.
    pause
    exit /b 1
)

echo.
echo [4/4] Attente du démarrage complet de l'application...
echo Cela peut prendre 30-60 secondes...
echo.

REM Attendre que Payara soit prêt (avec timeout de 90 secondes)
set /a count=0
set /a max_tries=18

:wait_loop
timeout /t 5 /nobreak >nul
docker inspect --format="{{.State.Health.Status}}" internship_wildfly 2>nul | findstr "healthy" >nul
if not errorlevel 1 (
    echo Payara est pret!
    goto :app_ready
)
set /a count+=1
if %count% LSS %max_tries% (
    echo Demarrage en cours... (%count%/%max_tries%)
    goto wait_loop
)
echo ATTENTION: Timeout atteint. L'application peut ne pas etre completement prete.

:app_ready
REM Attendre 5 secondes supplémentaires pour le déploiement complet
timeout /t 5 /nobreak >nul

echo.
echo =====================================
echo APPLICATION PRETE !
echo =====================================
echo.
echo L'application est accessible à:
echo   http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
echo.
echo Console d'administration Payara:
echo   http://localhost:4848/
echo.
echo MySQL:
echo   Host: localhost:3306
echo   Database: internship_management
echo   User: root
echo   Password: rootpassword
echo.
echo =====================================
echo.
echo Ouverture automatique dans votre navigateur...
timeout /t 3 /nobreak >nul

REM Ouvrir le navigateur
start http://localhost:8080/Internship_Management-1.0-SNAPSHOT/

echo.
echo Pour arrêter l'application, exécutez: docker-compose down
echo Pour voir les logs, exécutez: docker-compose logs -f
echo.
pause

