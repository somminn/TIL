URL Encoding
URL에 사용할 수 없는 문자를 % + 16진수로 변환하는 것

- URL은 오직 ASCII 문자만 사용 가능 
- 공백, 한글, 특수문자 같은 건 URL 규칙에 맞지 않기 때문에 변환해서 보내야 서버가 정확히 이해할 수 있음

변환 방법
1. 문자를 해당 바이트값(16진수)로 바꾼다.
2. 앞에 %를 붙인다.

예시
```markdown
원래 문자열: Hello World!
URL 인코딩: Hello%20World%21
```
