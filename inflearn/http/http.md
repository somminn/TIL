# HTTP 웹 기본 지식

## 인터넷 네트워크
### 인터넷 프로토콜 스택의 4계층

![Image](https://github.com/user-attachments/assets/32c41a2c-27a2-41be-964d-c9e21a8ef160)

![Image](https://github.com/user-attachments/assets/2bf9970a-f13f-4325-83e3-36bf65bb517a)

### 1. IP (인터넷 프로토콜)
#### IP의 역할
- 지정한 IP 주소에 데이터 전달
- 패킷(Packet)이라는 통신 단위로 데이터 전달

#### IP 패킷 정보
![Image](./user-attachments/assets/fcdb4b9e-f1a5-4cac-9c3c-9b6705d5f15e.jpg)

#### IP 프로토콜의 한계
- `비연결성`: 패킷을 받을 대상이 없거나 서비스 불능 상태여도 패킷 전송
- `비신뢰성`: 전달 도중에 패킷 소실, 패킷 전달 순서 문제 발생
- `프로그램 구분`: 같은 IP를 사용하는 서버에서 통신하는 애플리케이션이 둘 이상일 경우 구분이 어려움


### 2. TCP, UDP
#### `TCP`: 전송 제어 프로토콜(Transmission Control Protocol)
- 연결지향 - TCP 3 way handshake (가상 연결)
- 데이터 전달 보증
- 순서 보장

#### `UDP`: 사용자 데이터그램 프로토콜(User Datagram Protocol)
- 기능이 거의 없음
- 데이터 전달 및 순서가 보장되지 않지만, 단순하고 빠름
- IP와 거의 같다. +PORT +체크섬 정도만 추가

#### TCP/IP 패킷 정보
![Image](https://github.com/user-attachments/assets/b7d139fc-64bf-4492-9252-cdd88e1f9ee8)

### 3. Port
같은 IP 내에서 프로세스 구분하기 위해 사용한다.
- 0 ~ 65535 할당 가능
- 0 ~ 1023: 잘 알려진 포트, 사용하지 않는 것이 좋음

### 4. DNS
DNS: 도메인 네임 시스템(Domain Name System)
도메인 명을 IP 주소로 변환

### 5. URI

## 웹 브라우저 요청 흐름

## HTTP 기본