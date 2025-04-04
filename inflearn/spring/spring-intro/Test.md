# Test

메서드 선택 후 command + option + t : Test 생성

## Given-When-Then 패턴
- `given`: 테스트를 수행하기 위한 초기 상태나 조건을 설정
- `when`: 실제로 테스트하려는 동작을 수행
- `then`: 기대한 결과가 나왔는지 검증

```java
// 회원가입 테스트
void join() {
    // given 
    // 테스트에 사용할 멤버 객체 생성
    Member member = new Member(1L, "memberA", Grade.VIP);
    
    // when
    // join 메서드 실행
    memberService.join(member);
    Member findMember = memberService.findMember(1L);
    
    // then
    // 생성한 객체(member)가 join한 객체(findMember)와 동일한지 검증
    Assertions.assertThat(member).isEqualTo(findMember);
}
```


## assertThat
다양한 조건을 체이닝으로 연결이 가능한 메서드
```java
Assertions.assertThat(...)
```


## assertThrows
예외가 발생하는지 테스트할 때 사용하는 메서드
```java
Assertions.assertThrows(예외클래스.class, () -> {
    // 예외가 발생해야 하는 코드
});
```
아무 예외도 발생하지 않거나 다른 예외가 발생하면 테스트가 실패한다. 

