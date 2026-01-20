Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  INTERNSHIP MANAGEMENT - DEMARRAGE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "C:\Users\ROG STRIX\IdeaProjects\Internship_Management"

Write-Host "1. Arret des containers existants..." -ForegroundColor Yellow
docker-compose down -v

Write-Host ""
Write-Host "2. Demarrage des containers..." -ForegroundColor Yellow
docker-compose up -d --build

Write-Host ""
Write-Host "3. Attente du demarrage (30 secondes)..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

Write-Host ""
Write-Host "4. Verification du statut..." -ForegroundColor Yellow
docker-compose ps

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  APPLICATION PRETE !" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Ouvrez votre navigateur sur:" -ForegroundColor White
Write-Host "http://localhost:8080/Internship_Management-1.0-SNAPSHOT/" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pour voir les logs:" -ForegroundColor White
Write-Host "docker-compose logs -f app" -ForegroundColor Gray
Write-Host ""
Write-Host "Pour arreter:" -ForegroundColor White
Write-Host "docker-compose down" -ForegroundColor Gray
Write-Host ""

Read-Host "Appuyez sur Entree pour fermer"
