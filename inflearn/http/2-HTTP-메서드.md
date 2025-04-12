
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
![HTTP 메서드 속성](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-10%20%EC%98%A4%ED%9B%84%2011.30.00.png?raw=true)
- 안전(Safe Methods)
- 멱등(Idempotent Methods)
- 캐시가능(Cacheable Methods)

### 안전(Safe Methods)
호출해도 리소스를 변경하지 않는다.

### 멱등(Idempotent Methods)
한 번 호출하든 두 번 호출하든 100번 호출하든 결과가 똑같다.
- `GET`: 한 번 조회하든, 두 번 조회하든 같은 결과가 조회된다.
- `PUT`: 결과를 대체한다. 따라서 같은 요청을 여러번 해도 최종 결과는 같다.
- `DELETE`: 결과를 삭제한다. 같은 요청을 여러번 해도 삭제된 결과는 똑같다.
- `POST`: 멱등이 아니다! 두 번 호출하면 같은 결제가 중복해서 발생할 수 있다.

### 캐시가능(Cacheable Methods)
- 응답 결과 리소스를 캐시해서 사용
- GET, HEAD, POST, PATCH 캐시가능
- 실제로는 GET, HEAD 정도만 캐시로 사용


# [섹션 5. HTTP 메서드 활용]
## 클라이언트에서 서버로 데이터 전송
### 데이터 전달 방식
#### 1. 쿼리 파라미터를 통한 데이터 전송
- 메서드: GET
- 기능: 주로 정렬 필터(검색어)

#### 2. 메시지 바디를 통한 데이터 전송
- 메서드: POST, PUT, PATCH
- 기능: 회원 가입, 상품 주문, 리소스 등록, 리소스 변경


### 네가지 상황
#### 1. 정적 데이터 조회
- 이미지, 정적 텍스트 문서
- 조회는 GET 사용
- 쿼리 파라미터 없이 리소스 경로로 단순하게 조회 가능

#### 2. 동적 데이터 조회
- 주로 검색, 게시판 목록에서 정렬 필터(검색어)
- 조회 조건을 줄여주는 필터, 조회 결과를 정렬하는 정렬 조건에 주로 사용
- GET에 쿼리 파라미터 사용해서 데이터를 전달

#### 3. HTML Form을 통한 데이터 전송
- HTML Form submit시 POST 전송
    - 예) 회원 가입, 상품 주문, 데이터 변경
- Content-Type: application/x-www-form-urlencoded 사용
- HTML Form 전송은 GET, POST만 지원

#### 4. HTTP API를 통한 데이터 전송
- 서버 to 서버
- 앱 클라이언트, 웹 클라이언트
- POST, PUT, PATCH: 메시지 바디를 통해 데이터 전송
- GET: 조회, 쿼리 파라미터로 데이터 전달
- Content-Type: application/json을 주로 사용

## HTTP API 설계 예시
### HTTP API - 컬렉션
- POST 기반 등록
- 예) 회원 관리 API 제공
- 클라이언트는 등록될 리소스의 URI를 모른다.
- 서버가 새로 등록된 리소스 URI를 생성해준다.
    - Location: /members/100

#### 컬렉션(Collection)
- 서버가 관리하는 리소스 디렉토리로 서버가 리소스의 URI를 생성하고 관리한다.
- 여기서 컬렉션은 /members

### HTTP API - 스토어
- PUT 기반 등록
- 예) 정적 컨텐츠 관리, 원격 파일 관리
- 클라이언트가 리소스 URI를 알고 있어야 한다.
- 클라이언트가 직접 리소스의 URI를 지정한다.
    - /files/star.jpg

#### 스토어(Store)
- 클라이언트가 관리하는 리소스 저장소로 클라이언트가 리소스의 URI를 알고 관리한다.
- 여기서 스토어는 /fil es

### HTML FORM 사용
- HTML FORM은 GET, POST만 지원

#### 컨트롤 URI
- 메서드 제약을 해결하기 위해 동사로 된 리소스 경로 사용
- POST의 /new, /edit, /delete가 컨트롤 URI
- HTTP 메서드로 해결하기 애매한 경우 사용(HTTP API 포함)

## 참고하면 좋은 URI 설계 개념
- 문서(document)
    - 단일 개념(파일 하나, 객체 인스턴스, 데이터베이스 row)
    - 예) /members/100, /files/star.jpg
- 컬렉션(collection)
    - 서버가 관리하는 리소스 디렉터리 서버가 리소스의 URI를 생성하고 관리
    - 예) /members
- 스토어(store)
    - 클라이언트가 관리하는 자원 저장소
    - 클라이언트가 리소스의 URI를 알고 관리
    - 예) /files
- 컨트롤러(controller), 컨트롤 URI
    - 문서, 컬렉션, 스토어로 해결하기 어려운 추가 프로세스 실행
    - 동사를 직접 사용
    - 예) /members/{id}/delete
