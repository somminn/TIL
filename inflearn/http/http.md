# HTTP 웹 기본 지식

# [섹션 1. 인터넷 네트워크]
- IP (인터넷 프로토콜)
- TCP, UDP
- Port
- DNS


## 1. IP (인터넷 프로토콜)
### IP의 역할
- 지정한 IP 주소에 데이터 전달
- 패킷(Packet)이라는 통신 단위로 데이터 전달

### IP 패킷 정보
![IP 패킷 정보](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-09%20%EC%98%A4%ED%9B%84%207.36.30.png?raw=true)

### IP 프로토콜의 한계
- `비연결성`: 패킷을 받을 대상이 없거나 서비스 불능 상태여도 패킷 전송
- `비신뢰성`: 전달 도중에 패킷 소실, 패킷 전달 순서 문제 발생
- `프로그램 구분`: 같은 IP를 사용하는 서버에서 통신하는 애플리케이션이 둘 이상일 경우 구분이 어려움


## 2. TCP, UDP
### 인터넷 프로토콜 스택의 4계층
![인터넷 프로토콜 스택의 4계층](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-09%20%EC%98%A4%ED%9B%84%207.32.33.png?raw=true)
![프로토콜 계층](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-09%20%EC%98%A4%ED%9B%84%207.33.58.png?raw=true)

### `TCP`: 전송 제어 프로토콜(Transmission Control Protocol)
- 연결지향 - TCP 3 way handshake (가상 연결)
- 데이터 전달 보증
- 순서 보장

### `UDP`: 사용자 데이터그램 프로토콜(User Datagram Protocol)
- 기능이 거의 없음
- 데이터 전달 및 순서가 보장되지 않지만, 단순하고 빠름
- IP와 거의 같다. +PORT +체크섬 정도만 추가

### TCP/IP 패킷 정보
![TCP/IP 패킷 정보](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-09%20%EC%98%A4%ED%9B%84%207.36.38.png?raw=true)


## 3. Port
같은 IP 내에서 프로세스 구분하기 위해 사용한다.
- 0 ~ 65535 할당 가능
- 0 ~ 1023: 잘 알려진 포트, 사용하지 않는 것이 좋음

## 4. DNS
`DNS`: 도메인 네임 시스템(Domain Name System)
- 도메인 명을 IP 주소로 변환


# [섹션 2. URI와 웹 브라우저 요청 흐름]
- URI
- 웹 브라우저 요청 흐름

## 1. URI (Uniform Resource Identifier)
자원(Resource)을 식별하기 위한 통합 식별자로 하위 개념으로는 URL과 URN이 있다. 
- `Uniform`: 리소스 식별하는 통일된 방식
- `Resource`: 자원, URI로 식별할 수 있는 모든 것(제한 없음) 
- `Identifier`: 다른 항목과 구분하는데 필요한 정보

### URL(Uniform Resource Locator)
- 자원의 위치(주소)를 나타내는 URI
- 자주 사용

### URN(Uniform Resource Name)
- 자원의 이름을 나타내는 URI
- 거의 안씀

### URL 분석
`scheme://[userinfo@]host[:port][/path][?query][#fragment]`
`https://www.google.com:443/search?q=hello&hl=ko`

#### schema (https)
- 주로 프로토콜 사용
- 프로토콜: 어떤 방식으로 자원에 접근할 것인가 하는 약속 규칙 예) http, https, ftp 등등

#### userinfo (생략)
- URL에 사용자정보를 포함해서 인증 
- 거의 사용하지 않음

#### host (www.google.com)
- 호스트명
- 도메인명 또는 IP 주소를 직접 사용가능

#### port (:443)
- 접속 포트
- 일반적으로 생략, 생략시 http는 80, https는 443

#### path (search)
- 리소스 경로(path), 계층적 구조

#### query (?q=hello&hl=ko)
- key=value 형태
- ?로 시작, &로 추가 가능 ?keyA=valueA&keyB=valueB
- query parameter, query string 등으로 불림, 웹서버에 제공하는 파라미터, 문자 형태

#### fragment 
- html 내부 북마크 등에 사용

## 2. 웹 브라우저 요청 흐름

# [섹션 3. HTTP 기본]
`HTTP 메시지에 모든 것을 전송!`

## HTTP 역사
- `HTTP/1.1` 1997년: 가장 많이 사용, 우리에게 가장 중요한 버전
- `HTTP/2` 2015년: 성능 개선
- `HTTP/3` 진행중: TCP 대신에 UDP 사용, 성능 개선

## 기반 프로토콜
- `TCP`: HTTP/1.1, HTTP/2 
- `UDP`: HTTP/3

## HTTP 특징
- 클라이언트 서버 구조
- 무상태 프로토콜(Stateless), 비연결성
- HTTP 메시지 
- 단순함, 확장 가능

## 1. 클라이언트 서버 구조
- Request Response 구조
- 클라이언트는 서버에 요청을 보내고, 응답을 대기 
- 서버가 요청에 대한 결과를 만들어서 응답

## 2. 무상태 프로토콜 (Stateless), 비연결성
#### 무상태 프로토콜 (Stateless)
- 서버가 클라이언트의 상태를 보존하지 않음
- 장점: 서버 확장성 높음(스케일 아웃) 
- 단점: 클라이언트가 추가 데이터 전송


- `vs 상태 유지 프로토콜 (Stateful)` 
  : 응답 서버가 중간에 바뀌면 안된다.


- 모든 것을 무상태로 설계 할 수 있는 경우도 있고 없는 경우도 있다.
  - 무상태: 예) 로그인이 필요 없는 단순한 서비스 소개 화면
  - 상태 유지: 예) 로그인
- 일반적으로 브라우저 쿠키와 서버 세션등을 사용해서 상태 유지
- 상태 유지는 최소한만 사용

#### 비연결성
- HTTP 초기 / HTTP 지속 연결

![비연결성](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-10%20%EC%98%A4%ED%9B%84%206.33.42.png?raw=true)
- HTTP는 기본이 연결을 유지하지 않는 모델
- 서버 자원을 매우 효율적으로 사용할 수 있음


## 3. HTTP 메시지
HTTP 메시지 구조

![HTTP 메시지 구조](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-10%20%EC%98%A4%ED%9B%84%2010.30.33.png?raw=true)
- start-line
- header
- empty line 공백 라인 (CRLF)
- message body

### start-line
#### 요청 메시지 (request-line)  
```java
GET /search?q=hello&hl=ko HTTP/1.1
```
- `GET`: HTTP 메서드, 서버가 수행해야 할 동작 지정
- `/search?q=hello&hl=ko`: 요청 대상
- `HTTP/1.1`: HTTP Version

#### 응답 메시지 (status-line)  
```java
HTTP/1.1 200 OK
```
- `HTTP/1.1`: HTTP 버전
- `200`: HTTP 상태 코드
- `OK`: 이유 문구(사람이 이해할 수 있는 짧은 상태 코드 설명 글)

### header
- 용도: HTTP 전송에 필요한 모든 부가정보  
- 작성법: header-field = field-name ":" OWS field-value 
  - (OWS: 띄어쓰기 허용)
  - field-name은 대소문자 구문 없음

#### 요청 메시지  
```java
Host: www.google.com
```
#### 응답 메시지  
```java
Content-Type: text/html;charset=UTF-8  
Content-Length: 3423
```

### message body
- 실제 전송할 데이터
- HTML 문서, 이미지, 영상, JSON 등등 byte로 표현할 수 있는 모든 데이터 전송 가능


# [섹션 4. HTTP 메서드]
## API URI 설계
API URI를 설계할 떄 가장 중요한 것은 `리소스를 식별하는 것`이다.  
리소스(URI)와 해당 리소스를 대상으로 하는 행위(메서드)를 분리한다.

|    기능     | 행위 중심 설계                     | 리소스 중심 설계     |
|:---------:|:-----------------------------|:--------------|
| 회원 목록 조회  | /read-member-list            | /members      |
|   회원 조회   | /read-member-by-id           | /members/{id} |
|   회원 등록   | /create-member/create-member | /members/{id} |
|   회원 수정   | /update-member               | /members/{id} |
|   회원 삭제   | /delete-member               | /members/{id} |

## HTTP 메서드
리소스의 행동은 HTTP 메서드로 구분한다.

### GET
```java
GET /search?q=hello&hl=ko HTTP/1.1 
Host: www.google.com
```
- 리소스 조회
- 서버에 전달하고 싶은 데이터는 query(쿼리 파라미터, 쿼리 스트링)를 통해서 전달
- 메시지 바디를 사용해서 데이터를 전달할 수 있지만, 지원하지 않는 곳이 많아서 권장하지 않음

### POST
```java
POST /members HTTP/1.1 
Content-Type: application/json
{
"username": "hello", "age": 20
}
```
- 새 리소스 생성(등록)
- 요청 데이터 처리
- 다른 메서드로 처리하기 애매한 경우 POST

### PUT
```java
PUT /members/100 HTTP/1.1 
Content-Type: application/json
{
"username": "hello", "age": 20
}
```
- 리소스가 있으면 대체(덮어버림)
- 리소스가 없으면 생성
- 클라이언트가 리소스 위치를 알고 URI 지정(POST와 차이점)
  - POST: /members
  - PUT: /members/100

### PATCH
```java
PATCH /members/100 HTTP/1.1 
Content-Type: application/json
{
  "age": 50
}
```
- 리소스 부분 변경


### DELETE
```java
DELETE /members/100 HTTP/1.1 
Host: localhost:8080
```
- 리소스 제거

## HTTP 메서드 속성
- 안전(Safe Methods) 
- 멱등(Idempotent Methods) 
- 캐시가능(Cacheable Methods)

### 안전(Safe Methods)
### 멱등(Idempotent Methods)
### 캐시가능(Cacheable Methods)

