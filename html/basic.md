### `<ul>...</ul>`
`unordered list`: 순서 없는 목록을 만들 때 사용하는 태그

html 코드
```html
<ul>
  <li>사과</li>
  <li>바나나</li>
  <li>포도</li>
</ul>
```
표출 화면
```markdown
• 사과
• 바나나
• 포도
```

### `<ol>...</ol>`
`ordered list`: 순서 있는 목록을 만들 때 사용하는 태그

html 코드
```html
<ol>
  <li>첫 번째 항목</li>
  <li>두 번째 항목</li>
  <li>세 번째 항목</li>
</ol>
```
표출 화면
```markdown
1. 첫 번째 항목
2. 두 번째 항목
3. 세 번째 항목
```

### `<li>...</li>`
`list item`: 목록 항목을 나타내는 태그
- `<ul>...</ul>` 또는 `<ol>...</ol>` 안에서만 사용 가능


### `<span>...</span>`
출력 위치를 지정해주는 인라인 태그

html 코드
```html
<li>th:text 사용 <span th:text="${data}"></span></li>
```
표출 화면
```markdown
th:text 사용 Hello Spring!
```
- `<li>`: 목록 항목을 나타냄
- `th:text`: Thymeleaf 속성으로 서버에서 받은 데이터를 텍스트로 출력
- `${data}`: 컨트롤러에서 전달된 data 변수
- `<span>`: 그 데이터를 표시할 영역


<tr>...</tr>
<th>...</th>
<td>...</td>


<div>...</div>