<#
.SYNOPSIS
    현재 프로젝트를 GitHub, Vercel, Cloudflare에 동시 배포하는 스크립트
#>

param(
    [string]$TargetDir = "."
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# PATH 최신화
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$defaultPaths = @("C:\Program Files\Git\cmd", "C:\Program Files\GitHub CLI", "C:\Program Files\nodejs", "$env:APPDATA\npm")
foreach ($p in $defaultPaths) {
    if ((Test-Path $p) -and ($env:Path -notlike "*$p*")) {
        $env:Path = "$p;" + $env:Path
    }
}

Push-Location $TargetDir

$projName = (Get-Item .).Name.ToLower() -replace '[^a-z0-9\-]','-'
if (-not $projName) { $projName = "my-web-project" }

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " 🚀 3대 플랫폼 원클릭 자동 배포 시작: [$projName]" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Git 커밋
if (-not (Test-Path ".git")) {
    Write-Host "`n[1/4] Git 초기화..." -ForegroundColor Yellow
    git init
    git branch -M main
}
git add -A
git commit -m "Auto deploy via easy-deploy-kit" 2>$null

# 2. GitHub Push
Write-Host "`n[2/4] 🐙 GitHub 저장소 생성 및 푸시 중..." -ForegroundColor Cyan
gh repo create "$projName" --public --source=. --remote=origin --push 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "   (기존 저장소에 푸시합니다)" -ForegroundColor Gray
    git push -u origin main 2>$null
}

# 3. Vercel 배포
Write-Host "`n[3/4] ▲ Vercel 라이브 배포 중..." -ForegroundColor Cyan
npx vercel --prod --yes --name "$projName"

# 4. Cloudflare Pages 배포
Write-Host "`n[4/4] ⚡ Cloudflare Pages 배포 중..." -ForegroundColor Cyan
$distDir = "."
foreach ($d in @("dist", "build", "out", "public")) {
    if (Test-Path $d) { $distDir = $d; break }
}
npx wrangler pages deploy "$distDir" --project-name "$projName" --commit-dirty=true

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Green
Write-Host " ✨ 모든 배포가 완료되었습니다!" -ForegroundColor Green
Write-Host " 상단에 표시된 라이브 도메인(URL)으로 바로 접속해 보세요." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green

Pop-Location
