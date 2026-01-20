@echo off
cd "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"
echo Arret des containers existants...
docker-compose down -v
echo.
echo Construction de l'image...
docker-compose build --no-cache
echo.
echo Demarrage des containers...
docker-compose up -d
echo.
echo Attente du demarrage (30 secondes)...
timeout /t 30 /nobreak
echo.
echo Verification du statut...
docker-compose ps
echo.
echo Logs de l'application:
docker-compose logs app
echo.
echo ========================================
echo Application disponible sur:
echo http://localhost:8080/Internship_Management-1.0-SNAPSHOT/
echo ========================================
pause
