## 람다식이란?
다식(Lambda expression)은 익명 함수를 간결하게 표현하는 문법으로 주로 자바에서 함수형 인터페이스를 구현할 때 사용된다.

## 람다식 기본 구조
```java
(매개변수) -> { 실행문 }
```

### 람다식 함축 과정
메서드 타입, 메서드 이름, 매개변수 타입, 중괄호, return 생략 가능
```java
int add(int x, int y) {
    return x + y;
}

// 1. 메서트 반환 타입, 메서드 이름 생략
(int x, int y) -> {
    return x + y;
    };

// 2. 매개변수 타입 생략
(x, y) -> {
    return x + y;
};

// 3. 중괄호, return 생략
(x ,y) -> x + y;
```

## 람다식 장점 
- 코드 간결: 익명 클래스보다 훨씬 짧고 읽기 쉬움 
- 가독성 향상: 불필요한 클래스/메서드 선언 없이 의도를 표현 
- 함수형 프로그래밍 지원: Stream, map, filter 등과 함께 사용

## 람다식 예시
```java
import java.util.Arrays;
import java.util.List;

public class LambdaExample {
    public static void main(String[] args) {
        List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David");

        // 1. 이름이 'C'로 시작하는 사람만 출력
        names.stream()
             .filter(name -> name.startsWith("C"))
             .forEach(name -> System.out.println(name));

        // 2. 이름을 대문자로 바꿔 출력
        names.stream()
             .map(name -> name.toUpperCase())
             .forEach(name -> System.out.println(name));

        // 3. 이름 길이순으로 정렬
        names.stream()
             .sorted((a, b) -> Integer.compare(a.length(), b.length()))
             .forEach(System.out::println);
    }
}

```
