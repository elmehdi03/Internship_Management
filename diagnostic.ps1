Write-Host "=== DIAGNOSTIC INTERNSHIP MANAGEMENT ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "1. Status des containers:" -ForegroundColor Yellow
docker ps -a --filter "name=internship_management" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

Write-Host ""
Write-Host "2. Fichiers dans autodeploy:" -ForegroundColor Yellow
docker exec internship_management-app-1 sh -c "ls -lh /opt/payara/appserver/glassfish/domains/domain1/autodeploy/"

Write-Host ""
Write-Host "3. Applications deployees:" -ForegroundColor Yellow
docker exec internship_management-app-1 sh -c "ls -lh /opt/payara/appserver/glassfish/domains/domain1/applications/"

Write-Host ""
Write-Host "4. Test HTTP sur localhost:8080:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/" -UseBasicParsing -TimeoutSec 3
    Write-Host "Status Code: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Content Length: $($response.Content.Length) bytes"
} catch {
    Write-Host "ERROR: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "5. Test de l'application:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/Internship_Management-1.0-SNAPSHOT/" -UseBasicParsing -TimeoutSec 3
    Write-Host "Status Code: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "ERROR: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "6. Derniers logs Payara (20 lignes):" -ForegroundColor Yellow
docker logs internship_management-app-1 --tail 20

Write-Host ""
Write-Host "=== FIN DU DIAGNOSTIC ===" -ForegroundColor Cyan
