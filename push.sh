#!/bin/bash

# 커밋 메시지 입력받기
echo "Enter commit message: "
read commit_message

# Git 명령어 실행
git add .
git commit -m "$commit_message"
git push origin main

echo "Successfully pushed to GitHub!"

