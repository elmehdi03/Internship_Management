@echo off
echo ========================================
echo TEST APPLICATION
echo ========================================
echo.

echo 1. Status containers:
docker ps --filter "name=internship_management"
echo.

echo 2. Test page d'accueil Payara:
curl -s http://localhost:8080/ | findstr /C:"Payara" /C:"Error" /C:"404"
echo.

echo 3. Test application:
curl -s http://localhost:8080/Internship_Management-1.0-SNAPSHOT/ | findstr /C:"Internship" /C:"404" /C:"Error"
echo.

echo 4. Derniers logs (grep deploy):
docker exec internship_management-app-1 grep -i "deploy" /opt/payara/appserver/glassfish/domains/domain1/logs/server.log 2>nul | findstr /C:"Internship" | findstr /V /C:"#"
echo.

echo 5. Applications deployees:
docker exec internship_management-app-1 ls -la /opt/payara/appserver/glassfish/domains/domain1/applications/
echo.

echo 6. Fichiers autodeploy:
docker exec internship_management-app-1 ls -la /opt/payara/appserver/glassfish/domains/domain1/autodeploy/
echo.

echo ========================================
pause
