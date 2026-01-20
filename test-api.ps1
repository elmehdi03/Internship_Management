# Test script for Internship Management API
$BASE_URL = "http://localhost:8080/Internship_Management-1.0-SNAPSHOT/api"

Write-Host "=== Testing Internship Management API ===" -ForegroundColor Cyan

# Wait for application to be ready
Write-Host "`nWaiting for application to be ready..." -ForegroundColor Yellow
$maxRetries = 30
$retryCount = 0
$ready = $false

while (-not $ready -and $retryCount -lt $maxRetries) {
    try {
        $response = Invoke-WebRequest -Uri "$BASE_URL/students" -Method GET -TimeoutSec 2 -ErrorAction SilentlyContinue
        $ready = $true
        Write-Host "Application is ready!" -ForegroundColor Green
    } catch {
        $retryCount++
        Write-Host "Retry $retryCount/$maxRetries..." -ForegroundColor Gray
        Start-Sleep -Seconds 2
    }
}

if (-not $ready) {
    Write-Host "ERROR: Application is not responding after $maxRetries retries" -ForegroundColor Red
    exit 1
}

# Test 1: Create a student
Write-Host "`n--- Test 1: Create Student ---" -ForegroundColor Cyan
$studentData = @{
    name = "John Doe"
    email = "john.doe@example.com"
    major = "Computer Science"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BASE_URL/students" -Method POST -Body $studentData -ContentType "application/json"
    Write-Host "Student created successfully!" -ForegroundColor Green
    Write-Host ($response | ConvertTo-Json)
    $studentId = $response.id
} catch {
    Write-Host "ERROR creating student: $_" -ForegroundColor Red
}

# Test 2: Get all students
Write-Host "`n--- Test 2: Get All Students ---" -ForegroundColor Cyan
try {
    $students = Invoke-RestMethod -Uri "$BASE_URL/students" -Method GET
    Write-Host "Found $($students.Count) student(s)" -ForegroundColor Green
    $students | ForEach-Object { Write-Host "  - $($_.name) ($($_.email})" }
} catch {
    Write-Host "ERROR getting students: $_" -ForegroundColor Red
}

# Test 3: Create a company
Write-Host "`n--- Test 3: Create Company ---" -ForegroundColor Cyan
$companyData = @{
    name = "Tech Corp"
    industry = "Technology"
    location = "New York"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BASE_URL/companies" -Method POST -Body $companyData -ContentType "application/json"
    Write-Host "Company created successfully!" -ForegroundColor Green
    Write-Host ($response | ConvertTo-Json)
    $companyId = $response.id
} catch {
    Write-Host "ERROR creating company: $_" -ForegroundColor Red
}

# Test 4: Get all companies
Write-Host "`n--- Test 4: Get All Companies ---" -ForegroundColor Cyan
try {
    $companies = Invoke-RestMethod -Uri "$BASE_URL/companies" -Method GET
    Write-Host "Found $($companies.Count) company/companies" -ForegroundColor Green
    $companies | ForEach-Object { Write-Host "  - $($_.name) ($($_.industry))" }
} catch {
    Write-Host "ERROR getting companies: $_" -ForegroundColor Red
}

# Test 5: Create an internship
Write-Host "`n--- Test 5: Create Internship ---" -ForegroundColor Cyan
if ($studentId -and $companyId) {
    $internshipData = @{
        student = @{ id = $studentId }
        company = @{ id = $companyId }
        position = "Software Engineer Intern"
        startDate = "2026-06-01"
        endDate = "2026-08-31"
    } | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri "$BASE_URL/internships" -Method POST -Body $internshipData -ContentType "application/json"
        Write-Host "Internship created successfully!" -ForegroundColor Green
        Write-Host ($response | ConvertTo-Json)
    } catch {
        Write-Host "ERROR creating internship: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Skipping (no student or company ID)" -ForegroundColor Yellow
}

# Test 6: Get all internships
Write-Host "`n--- Test 6: Get All Internships ---" -ForegroundColor Cyan
try {
    $internships = Invoke-RestMethod -Uri "$BASE_URL/internships" -Method GET
    Write-Host "Found $($internships.Count) internship(s)" -ForegroundColor Green
    $internships | ForEach-Object {
        Write-Host "  - $($_.position) at $($_.company.name) for $($_.student.name)"
    }
} catch {
    Write-Host "ERROR getting internships: $_" -ForegroundColor Red
}

Write-Host "`n=== All Tests Completed ===" -ForegroundColor Cyan
Write-Host "You can now access the web interface at: http://localhost:8080/Internship_Management-1.0-SNAPSHOT/" -ForegroundColor Yellow
