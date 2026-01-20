@echo off
REM Script d'arrêt de l'application Internship Management

echo =====================================
echo Arrêt de l'application
echo =====================================
echo.

echo Arrêt des conteneurs Docker...
docker-compose down

echo.
echo =====================================
echo Application arrêtée avec succès !
echo =====================================
echo.
echo Les données sont conservées dans le volume Docker.
echo Pour supprimer aussi les données, exécutez: docker-compose down -v
echo.
pause

