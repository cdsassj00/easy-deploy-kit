# -*- coding: utf-8 -*-
"""
easy-deploy-kit: Python 환경용 원클릭 3대 플랫폼 자동 배포기
"""

import os
import sys
import subprocess

def run(cmd):
    print(f"\n[실행] {cmd}")
    res = subprocess.run(cmd, shell=True, text=True)
    return res.returncode == 0

def main():
    proj = os.path.basename(os.path.abspath(".")).lower().replace(" ", "-").replace("_", "-")
    proj = "".join(c for c in proj if c.isalnum() or c == "-") or "my-web-project"
    
    print(f"🚀 [easy-deploy-kit] 자동 배포 시작: {proj}")

    if not os.path.exists(".git"):
        run("git init && git branch -M main")
    run("git add -A")
    run('git commit -m "Auto deploy via easy-deploy-kit"')

    print("\n🐙 [GitHub] 저장소 생성 및 푸시...")
    if not run(f'gh repo create "{proj}" --public --source=. --remote=origin --push'):
        run("git push -u origin main")

    print("\n▲ [Vercel] 프로덕션 배포...")
    run(f'npx vercel --prod --yes --name "{proj}"')

    print("\n⚡ [Cloudflare Pages] 배포...")
    dist = next((d for d in ["dist", "build", "out", "public"] if os.path.exists(d)), ".")
    run(f'npx wrangler pages deploy "{dist}" --project-name "{proj}" --commit-dirty=true')

    print("\n✨ 모든 배포가 완료되었습니다!")

if __name__ == "__main__":
    main()
