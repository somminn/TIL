assertThat()

```java
assertThat(actual).isEqualTo(expected);
```
actual: 테스트 대상의 실제 결과
expected: 우리가 기대하는 값




isEqualTo() vs isSameAs()
`isEqualTo()`: 값(value)이 같은지를 비교함
`isSameAs()`: 객체 참조(reference)가 같은지를 비교함 (==)



static과 template

| 항목     | static HTML        | template HTML (예: Thymeleaf)      |
|:-------|:-------------------|:----------------------------------|
| 경로 예시  | /static/index.html | /templates/item.html              |
| 렌더링 방식 | 파일 그대로 보여줌         | 서버에서 데이터 채워서 만든 뒤 HTML로 응답        |  
| URL 처리 | 정적인 경로만 가능         | 변수 기반 동적 URL 가능                   |
| 예시     | /basic/items/add   | /basic/items/5 (itemId에 따라 변함)    |
| 변수 사용  | 못 씀                |  ${item.id}, th:href="@{...}" 가능  |