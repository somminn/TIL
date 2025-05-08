## AssertJ 기본 구조
값이 내가 예상한 값과 같은지 검증
```java
assertThat(실제값).검증메서드(기댓값);
```

## 주요 메서드 종류
### 1. 기본 값 비교
```java
assertThat(5).isEqualTo(5);              
assertThat(5).isNotEqualTo(3);           
assertThat(5).isGreaterThan(3);          // >
assertThat(5).isLessThan(10);            // <
```

### 2. 문자열 관련
```java
assertThat("Hello").startsWith("He");                   // "He" 으로 시작하는지
assertThat("Hello").endsWith("lo");                     // "lo" 로 끝나는지
assertThat("Hello").contains("ell");                    // "ell" 를 포함하는지
assertThat("Hello").isEqualToIgnoringCase("hello"); 
```

### 3. 컬렉션 관련
```java
List<Integer> list = List.of(1, 2, 3);
assertThat(list).contains(1, 2);                // 포함 여부
assertThat(list).containsExactly(1, 2, 3);      // 순서도 같아야 함
assertThat(list).isSorted();                   // 정렬된 상태인지 확인
```

### 4. 객체 참조 동일성 비교
```java
String a = "hello";
String b = a;
String c = new String("hello");

assertThat(a).isSameAs(b);        // 통과 (동일 참조)
assertThat(a).isNotSameAs(c);     // 통과 (다른 참조)
```

## 예외 테스트
- 예외가 내가 예상한 예외와 같은지 검증
- assertThat과 검증 방식은 같다, 검증 대상만 다르다
```java
// 1. 정말 예외가 발생했는가? 
assertThatThrownBy(() -> {

// 2. 예외 던지기 (발생시키기)
   throw new 예외클래스("예외 메시지");
    
// 3. 예외 타입이 맞는가?
}).isInstanceOf(예상하는 예외.class)
    
// 4. 예외 메시지가 정확하고, 필요한 키워드를 포함하는가?
  .hasMessage("예외 메시지")
  .hasMessageContaining("특정 문자열");
```
- `assertThatThrownBy()`: 특정 코드를 실행했을 때 예외가 발생하는지, 그리고 예외 타입, 메시지가 예상과 맞는지 확인
- `isInstanceOf(Class)`: 예외가 특정 클래스 타입인지 확인
- `hasMessage(Message)`: 전체 문자열이 정확히 같아야 통과
- `hasMessageContaining(String)`: 해당 문자열이 포함되어 있으면 통과

#### 예시
```java
assertThatThrownBy(() -> { 
    throw new IllegalArgumentException("입력값이 잘못되었습니다"); // 예외 던지기 (발생시키기)
}).isInstanceOf(IllegalArgumentException.class) 
  .hasMessage("입력값이 잘못되었습니다")
  .hasMessageContaining("입력값");
```