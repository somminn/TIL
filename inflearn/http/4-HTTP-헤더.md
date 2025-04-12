# [ HTTP 헤더 ]
HTTP 전송에 필요한 모든 부가정보

#### HTTP 메시지 구조
![HTTP 메시지 구조](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-10%20%EC%98%A4%ED%9B%84%2010.30.33.png?raw=true)

```java
1. 표현 헤더
2. 협상 헤더    
3. 일반 정보 헤더
4. 특별한 정보 헤더
```



HTTP 헤더
HTTP BODY
- 메시지 본문(message body)을 통해 표현 데이터 전달
- 메시지 본문 = 페이로드(payload)
- 표현 데이터: 요청이나 응답에서 전달할 실제 데이터
- 표현 헤더: 표현 데이터를 해석할 수 있는 정보 제공 
  - 데이터 유형(html, json), 데이터 길이, 압축 정보 등등

| 용어                      |	의미 | 예시                       |
|:------------------------|:--|:-------------------------|
| **리소스 (Resource)**      |	고유한 URL로 식별되는 대상| 	/members/1 = ID가 1인 사용자 |
| **표현 (Representation)** |	리소스를 전송 가능한 형태로 만든 것	| JSON, XML, HTML 등|        

표현 헤더
- Content-Type: 표현 데이터의 형식 설명
```html
Content-Type: text/html;charset=UTF-8

Content-Type: application/json

Content-Type: image/png
```

- Content-Encoding: 표현 데이터 인코딩
  - 표현 데이터를 압축하기 위해 사용 
  - 데이터를 전달하는 곳에서 압축 후 인코딩 헤더 추가 
  - 데이터를 읽는 쪽에서 인코딩 헤더의 정보로 압축 해제
```html
Content-Encoding: gzip

Content-Encoding: deflate

Content-Encoding: identity
```

- Content-Language: 표현 데이터의 자연 언어
```html
Content-Language: ko
Content-Language: en
Content-Language: en-US
```

- Content-Length: 표현 데이터의 길이
  - 바이트 단위로 표현
```html
Content-Length: 5
```


협상 헤더 (콘텐츠 네고시에이션)
Accept: 클라이언트가 선호하는 미디어 타입 전달 
Accept-Charset: 클라이언트가 선호하는 문자 인코딩 
Accept-Encoding: 클라이언트가 선호하는 압축 인코딩 
Accept-Language: 클라이언트가 선호하는 자연 언어

협상과 우선순위
- Quality Values(q) 값 사용
- 0~1, 클수록 높은 우선순위 (생략하면 1)
```html
GET /event
Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7

<!-- 1순위: ko-KR;q=1 (q생략), 2순위: ko;q=0.9, 3순위: en-US;q=0.8, 4순위: en;q=0.7 -->  
```
- 구체적일수록 높은 우선순위
```html
GET /event
Accept: text/*, text/plain, text/plain;format=flowed, */*

<!-- 1순위: text/plain;format=flowed, 2순위: text/plain, 3순위: text/*, 4순위: */* -->
```


전송 방식
Transfer-Encoding 
Range, Content-Range

단순 전송 
- Content-Length
```html
HTTP/1.1 200 OK
Content-Type: text/html;charset=UTF-8 
Content-Length: 3423

<html> 
<body>...</body>
</html>
```
압축 전송
- Content-Encoding
```html
HTTP/1.1 200 OK
Content-Type: text/html;charset=UTF-8 
Content-Encoding: gzip 
Content-Length: 521

lkj123kljoiasudlkjaweioluywlnfdo912u34ljko98udjkl
```

분할 전송 
- Transfer-Encoding
```html
HTTP/1.1 200 OK 
Content-Type: text/plain 
Transfer-Encoding: chunked

5
Hello
5 
World
0
\r\n
```
범위 전송
- Range, Content-Range
```html
GET /event
Range: bytes=1001-2000
```
```html
HTTP/1.1 200 OK
Content-Type: text/plain 
Content-Range: bytes 1001-2000 / 2000

qweqwe1l2iu3019u2oehj1987askjh3q98y
```


일반 정보 헤더
From: 유저 에이전트의 이메일 정보
Referer: 이전 웹 페이지 주소
User-Agent: 유저 에이전트 애플리케이션 정보
Server: 요청을 처리하는 오리진 서버의 소프트웨어 정보
Date: 메시지가 생성된 날짜

From: 유저 에이전트의 이메일 정보
- 일반적으로 잘 사용되지 않음
- 요청에서 사용

Referer: 이전 웹 페이지 주소
현재 요청된 페이지의 이전 웹 페이지 주소
A -> B로 이동하는 경우 B를 요청할 때 Referer: A 를 포함해서 요청
Referer를 사용해서 유입 경로 분석 가능


User-Agent: 유저 에이전트 애플리케이션 정보
클라이언트의 애플리케이션 정보(웹 브라우저 정보, 등등)
어떤 종류의 브라우저에서 장애가 발생하는지 파악 가능
요청에서 사용

Server: 요청을 처리하는 오리진 서버의 소프트웨어 정보
Server: Apache/2.2.22 (Debian) 
server: nginx
응답에서 사용


Date: 메시지가 생성된 날짜
Date: Tue, 15 Nov 1994 08:12:31 GMT
응답에서 사용




특별한 정보 헤더
Host: 요청한 호스트 정보(도메인)
Location: 페이지 리다이렉션
Allow: 허용 가능한 HTTP 메서드
Retry-After: 유저 에이전트가 다음 요청을 하기까지 기다려야 하는 시간

Host: 요청한 호스트 정보(도메인)
- 요청에서 필수로 사용
- 하나의 서버가 여러 도메인을 처리해야 할 때 식별 가능
```html
GET /search?q=hello&hl=ko HTTP/1.1 
Host: www.google.com
```

Location: 페이지 리다이렉션
웹 브라우저는 3xx 응답의 결과에 Location 헤더가 있으면, Location 위치로 자동 이동
- 201 (Created): Location 값은 요청에 의해 생성된 리소스 URI
- 3xx (Redirection): Location 값은 요청을 자동으로 리디렉션하기 위한 대상 리소스를 가리킴

Allow: 허용 가능한 HTTP 메서드
405 (Method Not Allowed) 에서 응답에 포함해야함 
Allow: GET, HEAD, PUT


Retry-After: 유저 에이전트가 다음 요청을 하기까지 기다려야 하는 시간
503 (Service Unavailable): 서비스가 언제까지 불능인지 알려줄 수 있음 
Retry-After: Fri, 31 Dec 1999 23:59:59 GMT (날짜 표기) 
Retry-After: 120 (초단위 표기)







인증
Authorization: 클라이언트 인증 정보를 서버에 전달
```html
Authorization: Basic xxxxxxxxxxxxxxxx
```



WWW-Authenticate: 리소스 접근시 필요한 인증 방법 정의
401 Unauthorized 응답과 함께 사용
```html
WWW-Authenticate: Newauth realm="apps", type=1, 
title="Login to \"apps\"", Basic realm="simple"
```





쿠키
Set-Cookie: 서버에서 클라이언트로 쿠키 전달(응답)
Cookie: 클라이언트가 서버에서 받은 쿠키를 저장하고, HTTP 요청시 서버로 전달


HTTP는 무상태(Stateless) 프로토콜이기 때문에 클라이언트가 다시 요청하면 서버는 이전 요청을 기억하지 못한다.



















