<#
.SYNOPSIS
    GitHub, Vercel, Cloudflare 브라우저 원클릭 연동 스크립트
#>

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

Clear-Host
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " 🌐 [easy-deploy-kit] 3대 플랫폼 브라우저 원클릭 로그인" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "복잡한 키 복사 없이 웹 브라우저에서 [승인] 버튼만 누르면 됩니다." -ForegroundColor Yellow
Write-Host ""

# 1. GitHub 로그인
Write-Host "----------------------------------------------------------" -ForegroundColor Gray
Write-Host "🐙 [1/3] GitHub 로그인 시작" -ForegroundColor Cyan
Write-Host "안내: 잠시 후 터미널에 8자리 코드가 뜨고 브라우저가 열립니다."
Write-Host "      웹페이지에 8자리 코드를 넣고 [Authorize]를 누르세요." -ForegroundColor Yellow
Write-Host "----------------------------------------------------------"
Write-Host "엔터를 누르면 GitHub 로그인을 시작합니다..." -NoNewline
Read-Host
gh auth login -w -p https

# 2. Vercel 로그인
Write-Host "`n----------------------------------------------------------" -ForegroundColor Gray
Write-Host "▲ [2/3] Vercel 로그인 시작" -ForegroundColor Cyan
Write-Host "안내: 브라우저가 열리면 [Continue with GitHub]를 클릭하세요." -ForegroundColor Yellow
Write-Host "----------------------------------------------------------"
Write-Host "엔터를 누르면 Vercel 로그인을 시작합니다..." -NoNewline
Read-Host
npx vercel login

# 3. Cloudflare 로그인
Write-Host "`n----------------------------------------------------------" -ForegroundColor Gray
Write-Host "⚡ [3/3] Cloudflare 로그인 시작" -ForegroundColor Cyan
Write-Host "안내: 브라우저가 열리면 Cloudflare 계정으로 [승인/Allow]를 누르세요." -ForegroundColor Yellow
Write-Host "----------------------------------------------------------"
Write-Host "엔터를 누르면 Cloudflare 로그인을 시작합니다..." -NoNewline
Read-Host
npx wrangler login

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Green
Write-Host " 🎉 3대 플랫폼 로그인이 모두 완료되었습니다!" -ForegroundColor Green
Write-Host " 이제 프로젝트 폴더에서 '더블클릭_배포.bat'을 누르면 즉시 배포됩니다." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
Write-Host "아무 키나 누르면 창을 닫습니다..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
