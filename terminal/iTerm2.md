## iTerm2 설치
###### mac 기본 터미널이 우클릭 붙여넣기가 안되어 iTerm2라는 터미널을 설치함

#### 1. iTerm2 설치 (터미널 강화)
```
brew install --cask iterm2
```
#### 2. Oh My Zsh 설치 (쉘 강화)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
#### 3. Tmux 설치 (세션 관리)
```
brew install tmux
```
<br>

***
### 커스텀
* 드래그한 영역 복사  
   iTerms2 - General - Selection - Copy ro pasteboard on selection 체크
  <br>
* 우클릭 붙여넣기  
   iTerms2 - Pointer - Bindings - Paste from Clipboard: ConvertPuctuation 을 right button으로 설정
  <br>
* 한글 깨짐   
   iTerms2 - Profiles - Text - Unicode normalization form NFC로 변경
  <br>
* 마우스 클릭 시 네모박스  
   iTerms2 - General - Selection - Clicking on a command selects it to restrict Find and Filter 체크 해제
  <br>
* 텍스트 커서 언더라인으로 변경  
   iTerms2 - Profiles - Text - Cusor Underline으로 변경
