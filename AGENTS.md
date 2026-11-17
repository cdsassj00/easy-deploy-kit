# 🤖 Instructions for AI Coding Agents (Antigravity, Cursor, Claude Code, etc.)

당신은 사용자의 컴퓨터 환경을 점검하고, 필요한 도구를 설치하며, 배포 파이프라인을 자동화하는 코딩 에이전트입니다.
사용자가 이 저장소(easy-deploy-kit)를 제공했을 때 다음 프로토콜을 **스스로 순서대로 실행**하세요.

---

## 🎯 목표
사용자가 Windows 10 또는 11 환경에서 복잡한 설정 없이 **GitHub, Vercel, Cloudflare Pages**를 사용할 수 있도록 무결점으로 지원합니다.

---

## ⚙️ 실행 프로토콜 (Agent Action Steps)

### Step 1. 환경 점검 및 원클릭 자동 설치
사용자가 "설치해줘", "세팅해줘"라고 요청하면:
1. 사용자의 OS가 Windows인지 확인합니다.
2. 터미널 도구(run_command 또는 bash/powershell)를 사용하여 저장소의 `setup.ps1`을 실행하세요:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\setup.ps1
   ```
   *(만약 저장소가 아직 로컬에 없다면, 아래 원라이너를 직접 실행하세요)*:
   ```powershell
   irm https://raw.githubusercontent.com/cdsassj00/easy-deploy-kit/main/setup.ps1 | iex
   ```
3. 설치가 끝나면 환경변수(PATH)가 메모리에 갱신되었으므로, 터미널을 재시작하지 않고 바로 다음 단계로 넘어갑니다.

### Step 2. 대화형 브라우저 로그인 창 띄우기
설치가 완료되면 사용자에게 다음 3대 로그인을 순서대로 실행해 줍니다:
1. **GitHub CLI**:
   - 실행: `gh auth login -w -p https`
   - 사용자 안내: *"터미널에 표시된 8자리 코드를 웹페이지에 입력하고 [Authorize]를 클릭해 주세요."*
2. **Vercel CLI**:
   - 실행: `npx vercel login`
   - 사용자 안내: *"브라우저가 열리면 [Continue with GitHub]를 클릭해 주세요."*
3. **Cloudflare Wrangler**:
   - 실행: `npx wrangler login`
   - 사용자 안내: *"브라우저에서 Cloudflare 승인([Allow]) 버튼을 클릭해 주세요."*

### Step 3. 원클릭 동시 배포 (Deploy Phase)
사용자가 "이 프로젝트 배포해줘", "웹사이트 올려줘"라고 요청하면:
1. 현재 프로젝트 디렉터리에서 `deploy.ps1`을 실행하세요:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\deploy.ps1
   ```
2. 배포 완료 후 출력된 **Vercel 라이브 URL**과 **Cloudflare Pages URL**을 추출하여 사용자에게 최종 링크로 안내하세요.
