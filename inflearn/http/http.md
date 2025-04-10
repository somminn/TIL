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

### 1. 클라이언트 서버 구조
- Request Response 구조
- 클라이언트는 서버에 요청을 보내고, 응답을 대기 
- 서버가 요청에 대한 결과를 만들어서 응답

### 2. 무상태 프로토콜 (Stateless), 비연결성
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

### 3. HTTP 메시지