# Logging
## 스프링 부트 로깅 라이브러리
- `SLF4J`: Logback, Log4J, Log4J2 등등 수 많은 로깅 라이브러리를 통합한 인터페이스
- `Logback`: SLF4J의 구현체

실무에서는 스프링 부트가 기본으로 제공하는 Logback을 대부분 사용한다.

## 로그 선언
- `private Logger log = LoggerFactory.getLogger(getClass());`
- `private static final Logger log = LoggerFactory.getLogger(Xxx.class)`
- `@Slf4j` : 롬복 사용 가능
  - 다음 코드를 자동으로 생성해서 로그를 선언해준다. 개발자는 편리하게 `log` 라고 사용하면 된다.
```java
private static final org.slf4j.Logger log =
org.slf4j.LoggerFactory.getLogger(RequestHeaderController.class);
```
## 로그 호출 
- `log.info("hello")`

## 로그 레벨
`TRACE > DEBUG > INFO > WARN > ERROR`
- 개발 서버는 debug 출력
- 운영 서버는 info 출력

## 올바른 로그 사용법
- `log.debug("data="+data)`  
로그 출력 레벨을 info로 설정해도 해당 코드에 있는 "data="+data가 실제 실행이 되어 버린다. 결과적으로 문자 더하기 연산이 발생한다. 
- `log.debug("data={}", data)`  
로그 출력 레벨을 info로 설정하면 아무일도 발생하지 않는다. 따라서 앞과 같은 의미없는 연산이 발생하지 않는다.

## 로그 사용시 장점
- 쓰레드 정보, 클래스 이름 같은 부가 정보를 함께 볼 수 있고, 출력 모양을 조정할 수 있다. 
- 로그 레벨에 따라 개발 서버에서는 모든 로그를 출력하고, 운영서버에서는 출력하지 않는 등 로그를 상황에 맞게 조절할 수 있다. 
- 시스템 아웃 콘솔에만 출력하는 것이 아니라, 파일이나 네트워크 등, 로그를 별도의 위치에 남길 수 있다. 특히 파일로 남길 때는 일별, 특정 용량에 따라 로그를 분할하는 것도 가능하다.