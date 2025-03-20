## 섹션 6. 컬렉션 프레임워크 - List

### 1. 리스트 추상화1 - 인터페이스 도입
`순서가 있고, 중복을 허용하는 자료 구조를 리스트(List)라 한다.`

MyArrayList 와 MyLinkedList 에서 같은 기능을 제공하는 메서드를 뽑아 MyList 라는 인터페이스로 만들어보자.
![MyList](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-19%20%EC%98%A4%ED%9B%84%207.56.21.png?raw=true)

### 2. 리스트 추상화2 - 의존관계 주입

#### 구체적인 클래스에 의존
아래 코드는 BatchProcessor 가 구체적인 클래스인 MyArrayList 에 의존한다고 표현할 수 있다.   
구체적인 클래스에 직접 의존하면 프레임워크 변경 시 BatchProcessor 코드도 수정해야 한다.
```java
public class BatchProcessor {
    private final MyArrayList<Integer> list = new MyArrayList<>();
}
```

#### 추상적인 MyList 에 의존
구체적인 클래스에 의존하는 대신 추상적인 MyList 인터페이스에 의존하면 코드를 수정하지 않아도 된다.
```java
public class BatchProcessor {
      private final MyList<Integer> list;
      public BatchProcessor(MyList<Integer> list) {
          this.list = list;
}
```
#### 의존관계 주입 : DI(Dependency Injection)
`의존관계 주입이란 외부에서 의존관계가 결정되어서 인스턴스에 들어오는 것!`   
BatchProcessor 를 생성하는 시점에 생성자를 통해 원하는 리스트 전략(알고리즘)을 선택해서 전달하면 된다.   
생성자를 통해 런타임 의존관계를 주입하는 것을 생성자 의존관계 주입 또는 줄여서 생성자 주입이라 한다.
```java
main() {
    new BatchProcessor(new MyArrayList()); //MyArrayList를 사용하고 싶을 때 
    new BatchProcessor(new MyLinkedList()); //MyLinkedList를 사용하고 싶을 때
}
```


### 3. 리스트 추상화3 - 컴파일 타임, 런타임 의존관계

#### 의존관계 종류
- 컴파일 타임 의존관계 : 코드 컴파일 시점
- 런타임 의존관계 : 프로그램 실행 시점 

   
#### 컴파일 타임 의존관계
`컴파일 타임 의존관계는 실행하지 않은 소스 코드에서 자바 컴파일러가 정적으로 분석하는 의존 관계이다.`
![컴파일 타임 의존관계]()
BatchProcessor 는 MyList 인터페이스에만 의존한다.


#### 런타임 의존관계
`런타임 의존관계는 프로그램 실행 시점에 인스턴스 간에 형성되는 의존 관계이다.`
![런타임 의존관계]()















### 메모
- 시간 계산
```java
long startTime = System.currentTimeMillis();
// 작업 코드
long endTime = System.currentTimeMillis();
System.out.println("크기: " + size + ", 계산 시간: " + (endTime - startTime) + "ms");

```