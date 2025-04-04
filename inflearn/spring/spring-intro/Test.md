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