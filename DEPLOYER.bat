@echo off
chcp 65001 >nul
echo ========================================
echo   Déploiement Application de Gestion des Stages
echo ========================================
echo.

cd /d "%~dp0"

echo [1/5] Arrêt des conteneurs existants...
docker-compose down -v 2>nul
echo       ✓ Conteneurs arrêtés
echo.

echo [2/5] Compilation du projet Maven...
call mvn clean package -DskipTests
if errorlevel 1 (
    echo       ✗ ERREUR lors de la compilation
    pause
    exit /b 1
)
echo       ✓ Compilation réussie
echo.

echo [3/5] Construction de l'image Docker...
docker-compose build --no-cache
if errorlevel 1 (
    echo       ✗ ERREUR lors du build Docker
    pause
    exit /b 1
)
echo       ✓ Image construite
echo.

echo [4/5] Démarrage des conteneurs...
docker-compose up -d
if errorlevel 1 (
    echo       ✗ ERREUR lors du démarrage
    pause
    exit /b 1
)
echo       ✓ Conteneurs démarrés
echo.

echo [5/5] Attente du démarrage (30 secondes)...
timeout /t 30 /nobreak >nul
echo       ✓ Démarrage terminé
echo.

echo ========================================
echo   Déploiement terminé avec succès !
echo ========================================
echo.
echo URLs disponibles :
echo   • Page principale : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
echo   • API REST        : http://localhost:8080/Internship_Management-1.0-SNAPSHOT/api/students
echo.
echo Appuyez sur une touche pour ouvrir le navigateur...
pause >nul
start http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
