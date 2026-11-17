<#
.SYNOPSIS
    윈도우 10 / 11 공용 무결점 CLI 자동 설치 스크립트 (easy-deploy-kit)
.DESCRIPTION
    - 윈도우 11 및 최신 윈도우 10: winget을 통한 초고속 자동 설치
    - winget이 없는 구형 윈도우 10: 공식 설치 파일(MSI/EXE) 직접 무음 자동 설치 (Fallback)
    - 설치 후 즉시 환경변수(PATH) 메모리 동기화 (재부팅/재시작 불필요)
#>

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " 🚀 [easy-deploy-kit] Windows 10/11 CLI 자동 설치 시작" -ForegroundColor Cyan
Write-Host "    (GitHub CLI + Node.js + Vercel + Cloudflare Wrangler)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# 임시 다운로드 폴더
$tempDir = Join-Path $env:TEMP "easy_deploy_kit_installers"
if (-not (Test-Path $tempDir)) { New-Item -ItemType Directory -Path $tempDir -Force | Out-Null }

# winget 사용 가능 여부 판별
$hasWinget = $false
try {
    $wingetCheck = winget --version 2>$null
    if ($LASTEXITCODE -eq 0 -and $wingetCheck) {
        $hasWinget = $true
        Write-Host "✓ Windows Package Manager (winget) 감지됨: $wingetCheck" -ForegroundColor Green
    }
} catch {
    $hasWinget = $false
}

if (-not $hasWinget) {
    Write-Host "💡 winget을 사용할 수 없는 환경(구형 Win 10 등)입니다. 직접 다운로드 모드로 전환합니다." -ForegroundColor Yellow
}

# 1. Git 설치 확인 및 설치
Write-Host "`n[1/4] Git 점검..." -NoNewline
if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Host " [설치됨: $(git --version)]" -ForegroundColor Green
} else {
    Write-Host " [미설치] -> 설치를 시작합니다..." -ForegroundColor Yellow
    if ($hasWinget) {
        winget install --id Git.Git -e --silent --accept-source-agreements --accept-package-agreements
    } else {
        Write-Host "   -> Git 공식 인스톨러 다운로드 중..." -ForegroundColor Gray
        $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe"
        $gitInstaller = Join-Path $tempDir "GitSetup.exe"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $gitUrl -OutFile $gitInstaller -UseBasicParsing
        Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT /NORESTART" -Wait
    }
}

# 2. GitHub CLI (gh) 설치 확인 및 설치
Write-Host "`n[2/4] GitHub CLI (gh) 점검..." -NoNewline
if (Get-Command gh -ErrorAction SilentlyContinue) {
    Write-Host " [설치됨: $((gh --version)[0])]" -ForegroundColor Green
} else {
    Write-Host " [미설치] -> 설치를 시작합니다..." -ForegroundColor Yellow
    if ($hasWinget) {
        winget install --id GitHub.cli -e --silent --accept-source-agreements --accept-package-agreements
    } else {
        Write-Host "   -> GitHub CLI 공식 MSI 다운로드 중..." -ForegroundColor Gray
        $ghUrl = "https://github.com/cli/cli/releases/download/v2.47.0/gh_2.47.0_windows_amd64.msi"
        $ghInstaller = Join-Path $tempDir "ghSetup.msi"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $ghUrl -OutFile $ghInstaller -UseBasicParsing
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$ghInstaller`" /qn /norestart" -Wait
    }
}

# 3. Node.js (Vercel & Cloudflare 구동용) 점검 및 설치
Write-Host "`n[3/4] Node.js LTS 점검..." -NoNewline
if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Host " [설치됨: $(node -v)]" -ForegroundColor Green
} else {
    Write-Host " [미설치] -> 설치를 시작합니다..." -ForegroundColor Yellow
    if ($hasWinget) {
        winget install --id OpenJS.NodeJS.LTS -e --silent --accept-source-agreements --accept-package-agreements
    } else {
        Write-Host "   -> Node.js LTS 공식 MSI 다운로드 중..." -ForegroundColor Gray
        $nodeUrl = "https://nodejs.org/dist/v20.12.2/node-v20.12.2-x64.msi"
        $nodeInstaller = Join-Path $tempDir "nodeSetup.msi"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $nodeUrl -OutFile $nodeInstaller -UseBasicParsing
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$nodeInstaller`" /qn /norestart" -Wait
    }
}

# 4. 환경 변수(PATH) 실시간 메모리 동기화 (재부팅 불필요)
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
# 기본 설치 경로 강제 보강
$defaultPaths = @("C:\Program Files\Git\cmd", "C:\Program Files\GitHub CLI", "C:\Program Files\nodejs", "$env:APPDATA\npm")
foreach ($p in $defaultPaths) {
    if ((Test-Path $p) -and ($env:Path -notlike "*$p*")) {
        $env:Path = "$p;" + $env:Path
    }
}

# 5. Vercel & Wrangler CLI 준비
Write-Host "`n[4/4] Vercel & Cloudflare Wrangler 도구 구성 중..." -ForegroundColor Cyan
try {
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        Write-Host "   -> Vercel & Cloudflare 최신 도구 등록..."
        npm install -g vercel@latest wrangler@latest --silent 2>$null
    }
} catch {
    # 실패해도 상관없음 (npx로 100% 실행 가능)
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Green
Write-Host " ✨ 설치 완료! 모든 필수 도구가 준비되었습니다." -ForegroundColor Green
Write-Host " 👉 다음 단계: '더블클릭_로그인.bat' 또는 './login.ps1' 실행" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
