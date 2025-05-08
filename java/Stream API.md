## Stream API 란?
- 컬렉션 데이터를 함수형 스타일로 처리할 수 있도록 도와주는 도구
- Java 컬렉션(List, Set 등)의 데이터를 반복문 없이, 선언형(무엇을 할지만 표현) 방식으로 처리할 수 있는 기능

## Stream API 기본 구조
```java
리스트.stream()
      .중간연산1()
      .중간연산2()
      ...
      .최종연산();
```
`stream()`: 컬렉션 데이터를 하나씩 꺼내서, 연속적인 연산을 처리할 수 있도록 도와주는 통로

## Stream API 동작 방식
```java
// 1. 데이터 소스 생성
List<String> names = List.of("Alice", "Bob", "Charlie");
names.stream()

// 2. 중간 연산 (중첩 가능)
.filter(name -> name.startsWith("A"))
.map(String::toUpperCase)
.sorted()

// 3. 최종 연산 (실행)
.forEach(System.out::println);
```

## 주요 연산 정리
| 구분    | 메서드                      | 설명              |
| ----- | ------------------------ | --------------- |
| 중간 연산 | `filter()`               | 조건으로 걸러냄        |
| 중간 연산 | `map()`                  | 값 변환            |
| 중간 연산 | `sorted()`, `distinct()` | 정렬, 중복 제거       |
| 최종 연산 | `forEach()`              | 요소 반복 처리        |
| 최종 연산 | `collect()`              | 리스트 등으로 수집      |
| 최종 연산 | `count()`, `anyMatch()`  | 개수 세기, 조건 매칭 확인 |
