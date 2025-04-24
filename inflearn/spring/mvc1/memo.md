assertThat()

```java
assertThat(actual).isEqualTo(expected);
```
actual: 테스트 대상의 실제 결과
expected: 우리가 기대하는 값




isEqualTo() vs isSameAs()
`isEqualTo()`: 값(value)이 같은지를 비교함
`isSameAs()`: 객체 참조(reference)가 같은지를 비교함 (==)