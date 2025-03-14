## push.sh 생성
### 1. 경위
반복적인 push로 특정 명령어들을 매번 입력하는 것이 비효율적이라는 생각을 했다.

### 2. 기존 명령어
git add .  
git commit -m "message"  
git push origin main

### 3. 쉘 생성 
```
#!/bin/bash

# 커밋 메시지 입력받기
echo "Enter commit message: "
read commit_message

# Git 명령어 실행
git add .
git commit -m "$commit_message"
git push origin main

echo "Successfully pushed to GitHub!"
```

### ssh-agent에 패스프레이즈 저장

쉘을 실행할때마다 ssh 비밀번호를 입력하는 것이 번거로웠다.   
하지만 아예 삭제하는 것은 보안이 약해지므로 세션이 살아있는 동안은 비밀번호를 다시 입력하지 않도록 설정했다.
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_xxxxxxx
ssh -T git@github.com
```
