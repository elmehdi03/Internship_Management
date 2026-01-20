$ErrorActionPreference = "Continue"

Write-Host "=== ETAT APPLICATION ===" -ForegroundColor Cyan

Write-Host "`n1. Applications deployees:" -ForegroundColor Yellow
docker exec internship_management-app-1 sh -c "ls -lh /opt/payara/appserver/glassfish/domains/domain1/applications/ 2>&1"

Write-Host "`n2. Statut autodeploy:" -ForegroundColor Yellow
docker exec internship_management-app-1 sh -c "ls -lh /opt/payara/appserver/glassfish/domains/domain1/autodeploy/*war* 2>&1"

Write-Host "`n3. Test HTTP:" -ForegroundColor Yellow
try {
    $result = curl.exe -s -w "%{http_code}" http://localhost:8080/Internship_Management-1.0-SNAPSHOT/ 2>&1
    $code = $result[-3..-1] -join ''
    Write-Host "HTTP Code: $code"
    if ($code -eq "200") {
        Write-Host "SUCCESS - Application accessible!" -ForegroundColor Green
    } else {
        Write-Host "FAILED - Code $code" -ForegroundColor Red
    }
} catch {
    Write-Host "ERROR: $_" -ForegroundColor Red
}

Write-Host "`n4. Recherche erreurs dans logs:" -ForegroundColor Yellow
docker exec internship_management-app-1 sh -c "grep -i 'error\|exception\|failed' /opt/payara/appserver/glassfish/domains/domain1/logs/server.log 2>&1 | grep -i internship | tail -5"

Write-Host "`n=== FIN ===" -ForegroundColor Cyan
