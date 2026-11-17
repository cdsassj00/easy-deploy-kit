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

## ⚡ 초간단 사용법 (택 1)

### 방법 A. 터미널에 한 줄만 복사-붙여넣기 (가장 빠름!)
Windows PowerShell을 열고 아래 한 줄을 붙여넣고 엔터를 치면 끝납니다. (Git이 없어도 바로 실행됩니다)

```powershell
irm https://raw.githubusercontent.com/cdsassj00/easy-deploy-kit/main/setup.ps1 | iex
```

---

### 방법 B. 마우스 더블클릭으로 사용하기 (초보자 추천)
1. 이 저장소를 다운로드(또는 `git clone https://github.com/cdsassj00/easy-deploy-kit.git`)합니다.
2. **`더블클릭_설치.bat`** 더블클릭 ➡️ 필수 도구(Git, GitHub CLI, Node.js) 자동 설치
3. **`더블클릭_로그인.bat`** 더블클릭 ➡️ 브라우저가 차례로 열리면 [승인] 클릭
4. 내 프로젝트 폴더에서 **`더블클릭_배포.bat`** 더블클릭 ➡️ GitHub, Vercel, Cloudflare에 3초 만에 동시 배포!

---

### 방법 C. 코딩 에이전트(Antigravity, Cursor 등)에게 시키기
채팅창에 아래 문장을 그대로 복사해서 붙여넣으세요:

> *"easy-deploy-kit의 setup.ps1을 실행해서 필요한 CLI를 다 설치해주고, GitHub, Vercel, Cloudflare 로그인 창을 순서대로 띄워줘."*

---

## 📁 파일 구성 안내

| 파일명 | 설명 |
| :--- | :--- |
| **`setup.ps1`** | Win 10/11 자동 감지 및 Git, Node.js, GitHub CLI, Vercel, Wrangler 자동 설치 엔진 |
| **`login.ps1`** | 3사 브라우저 로그인 창 순차 안내 스크립트 |
| **`deploy.ps1`** | 현재 웹 프로젝트를 GitHub + Vercel + Cloudflare Pages에 원클릭 동시 배포 |
| **`deploy.py`** | 파이썬 환경에서 동일하게 배포를 수행할 수 있는 스크립트 |
| **`더블클릭_*.bat`** | 명령어가 낯선 수강생을 위한 마우스 원클릭 실행 런처 3종 |

---

## 🛠️ 수동 명령어 요약 (참고용)

```powershell
# 1. 설치
powershell -ExecutionPolicy Bypass -File .\setup.ps1

# 2. 로그인 (브라우저 승인)
powershell -ExecutionPolicy Bypass -File .\login.ps1

# 3. 배포
powershell -ExecutionPolicy Bypass -File .\deploy.ps1
```

---
제작: 공공/교육청 AI & 소프트웨어 실습 교육을 위한 Zero-Friction 배포 자동화 키트
