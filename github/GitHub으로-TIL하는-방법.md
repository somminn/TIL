<GitHub으로 TIL하는 방법>
## 1. GitHub 저장소 만들기
1. GitHub에 로그인하고 새 저장소 생성 페이지로 이동
2. Repository name: TIL 입력
3. Add a README file 체크 후, Create repository 클릭

## 2. 로컬에 TIL 저장소 클론하기
1. 원하는 디렉토리에서 clone
   git clone https://github.com/GitHub아이디/TIL.git
   cd TIL

## 3. 폴더 및 파일 구조 만들기
1. 디렉토리 생성
   mkdir Java
2. 파일 생성
   echo "Java" > Java/README.md
   #Git은 빈 폴더는 관리하지 않기때문에 폴더를 만들고 .md 같은 파일을 하나 추가하고 커밋해야함 -> 커밋 방법은 후술

## 4. 학습한 내용 기록하기
예시: 2025-02-28-git-기본명령어.md

## 5. 파일 추가 및 커밋
1. 파일 스테이징
   git add .
   #(현재 폴더에서 하위까지) 변경된 모든 파일을 스테이징
   git add README.md
   #해당 파일을 스테이징

<!-- Git에서 파일이 "추적(tracked)"되려면 3가지 상태 중 하나여야함
1. Untracked (미추적 상태): Git이 아직 모르는 파일
2. Modified (수정됨): Git이 알고 있지만, 아직 기록되지 않은 변경 사항이 있는 파일
3. Staged (스테이징됨): Git에 기록할 준비가 된 상태
즉, git add .을 하지 않으면 파일이 스테이징 되지 않아서 git commit을 해도 변경사항이 반영되지 않음 -->

2. 커밋
   git commit -m "메시지"
   #로컬 저장소에 변경사항 저장 (GitHub에는 아직 안올라감)
<!-- 커밋(commit): 변경 사항을 로컬(local) 저장소에 저장하는 것
푸시(push): 로컬 저장소의 커밋을 GitHub(원격 저장소)에 업로드하는 것 -->

## 6. GitHub에 올리기 (Push)
git push origin main

#GitHub 푸시할 때 비밀번호 입력이 안 되는 문제 해결 방법
에러 로그 : Authentication failed
1. SSH 키 생성
   ssh-keygen -t ed25519 -C "GitHub 가입한 이메일 주소"
   ~/.ssh/id_ed25519.pub 파일이 생성됨

2. GitHub에 SSH 키 등록
   GitHub SSH 설정 페이지 - New SSH Key - id_ed25519.pub 파일 내용을 복사하여 붙여넣기
   터미널에서 테스트
   ssh -T git@github.com
   "Hi <your_username>! You've successfully authenticated!" 메시지가 나오면 성공

3. Git 저장소의 원격 URL을 SSH로 변경
   git remote set-url origin git@github.com:GitHub아이디/TIL.git

## 7. 전체 흐름도
1. git add . → Git이 변경된 파일을 추적하도록 준비
2. git commit -m "메시지" → 변경 사항을 로컬 저장소에 저장
3. git push origin main → GitHub에 업로드
