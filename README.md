# 🚀 easy-deploy-kit

> **Windows 10 / 11 강의 실습용 원클릭 CLI 셋업 & 3대 플랫폼(GitHub, Vercel, Cloudflare) 자동 배포 키트**  
> 복잡한 명령어, 환경변수(PATH) 설정, 2FA 토큰 복사 없이 **웹 브라우저 클릭과 마우스 더블클릭만으로 모든 세팅과 배포를 끝냅니다.**

---

## ✨ 왜 이 키트인가요?

- **윈도우 10 & 11 100% 호환**: 최신 윈도우 11의 `winget`뿐 아니라, winget이 없는 **구형 윈도우 10(학교/관공서 PC)**에서도 공식 설치 파일을 직접 다운로드하여 무결점으로 자동 설치합니다.
- **환경변수(PATH) 실시간 자동 주입**: 프로그램을 깔아도 터미널을 껐다 켤 필요 없이 즉시 명령어가 인식됩니다.
- **토큰 복사 없는 웹 OAuth 로그인**: 복잡한 API 토큰 대신, 브라우저가 자동으로 열려 [승인] 버튼만 누르면 2FA까지 통과됩니다.
- **npx 기반 실행**: Vercel과 Cloudflare 도구를 전역 설치 오류 걱정 없이 100% 안정적으로 실행합니다.

---

## ⚡ 초간단 사용법 (3가지 중 편한 방식 선택)

### 🥇 방법 A. 터미널에 한 줄만 복사-붙여넣기 (가장 빠름!)
Windows PowerShell을 열고 아래 한 줄을 붙여넣고 엔터를 치면 끝납니다. (Git/Node가 없어도 바로 실행됩니다)

```powershell
irm https://raw.githubusercontent.com/cdsassj00/easy-deploy-kit/main/setup.ps1 | iex
```

---

### 🥈 방법 B. 마우스 더블클릭으로 사용하기 (명령어가 낯선 초보자 추천)
1. 이 저장소를 다운로드(또는 `git clone https://github.com/cdsassj00/easy-deploy-kit.git`)합니다.
2. **`더블클릭_설치.bat`** 더블클릭 ➡️ 필수 도구(Git, GitHub CLI, Node.js) 자동 설치
3. **`더블클릭_로그인.bat`** 더블클릭 ➡️ 브라우저가 차례로 열리면 [승인] 클릭 (2FA 자동 통과)
4. 내 실습 프로젝트 폴더에서 **`더블클릭_배포.bat`** 더블클릭 ➡️ GitHub, Vercel, Cloudflare에 3초 만에 동시 배포!

---

### 🥉 방법 C. 코딩 에이전트(Antigravity, Cursor 등)에게 시키기
채팅창에 아래 문장을 그대로 복사해서 붙여넣으세요:

#### 1단계 (설치 및 로그인할 때)
```text
easy-deploy-kit의 setup.ps1을 실행해서 필요한 CLI를 다 설치해주고, GitHub, Vercel, Cloudflare 로그인 창을 순서대로 띄워줘.
```

#### 2단계 (프로젝트 완성 후 배포할 때)
```text
지금 만든 이 프로젝트를 easy-deploy-kit의 deploy.ps1을 이용해 GitHub, Vercel, Cloudflare Pages에 원클릭으로 동시 배포하고 접속 URL을 알려줘.
```

---

## 📁 파일 구성 안내

| 파일명 | 설명 |
| :--- | :--- |
| **`setup.ps1`** | Win 10/11 자동 감지 및 Git, Node.js, GitHub CLI, Vercel, Wrangler 자동 설치 엔진 (Fallback 포함) |
| **`login.ps1`** | 3사 브라우저 로그인 창 순차 안내 스크립트 |
| **`deploy.ps1`** | 현재 웹 프로젝트를 GitHub + Vercel + Cloudflare Pages에 원클릭 동시 배포 |
| **`deploy.py`** | 파이썬 환경에서 동일하게 배포를 수행할 수 있는 스크립트 |
| **`더블클릭_*.bat`** | 명령어가 낯선 수강생을 위한 마우스 원클릭 실행 런처 3종 |

---

## 🧑‍🏫 강사용 강의 운영 꿀팁 (FAQ)

### Q1. 수강생이 2FA(이중 인증) 때문에 CLI 로그인을 못해요!
> 토큰을 발급받을 필요가 없습니다. `login.ps1`이나 `더블클릭_로그인.bat`을 실행하면 터미널에 8자리 코드가 뜨고 웹 브라우저가 열립니다. 웹페이지에 코드만 넣고 **[Authorize]** 버튼을 누르면 2FA 인증이 브라우저에서 자동으로 끝납니다.

### Q2. 학교나 공공기관 PC에서 `winget`이나 `npm`이 안 먹혀요!
> `setup.ps1` 내부에는 winget이 없는 환경을 자동 감지하여, 마이크로소프트/Git 공식 서버에서 직접 MSI 설치 파일을 무음 다운로드/설치하는 Fallback 코드가 탑재되어 있습니다.

### Q3. 배포 시 Vercel과 Cloudflare에 동시에 올라가나요?
> 네, `deploy.ps1` (또는 `더블클릭_배포.bat`)을 실행하면 먼저 GitHub에 새 리포지토리를 파서 Push한 뒤, Vercel과 Cloudflare Pages에 각각 프로젝트를 생성하여 실서비스 URL을 터미널에 바로 찍어줍니다.

---
제작: 공공/교육청 AI & 소프트웨어 실습 교육을 위한 Zero-Friction 배포 자동화 키트
