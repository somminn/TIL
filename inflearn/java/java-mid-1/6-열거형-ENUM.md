## 섹션 6. 열거형 - ENUM
<br>

### 1. 문자열과 타입 안정성1
### 2. 문자열과 타입 안정성2
#### 등급에 String 사용 시 안전성 부족 문제
- 값의 제한 부족 : 잘못된 문자열을 실수로 입력할 가능성이 있음
- 컴파일 시 오류 감지 불가 : 런타임에서만 문제가 발견되기 때문에 디버깅 어려움
<br>

### 3. 타입 안전 열거형 패턴 - Type-Safe Enum Pattern 
#### 타입 안전 열거형 패턴이란?
> 상수값을 보다 안전하게 관리하기 위해 클래스를 활용하는 패턴
> ###### 요약 : 나열된 항목만 사용할 수 있는 패턴

![Type-Safe Enum Pattern](https://raw.githubusercontent.com/somminn/TIL/refs/heads/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-07%20%EC%98%A4%EC%A0%84%2010.54.55.png)  
<br>

#### 타입 안전 열거형 패턴의 장점
- 타입 안전성 향상 : 정해진 객체만 사용할 수 있기 때문에 잘못된 값을 입력하는 문제를 근본적으로 방지함
- 데이터 일관성 : 정해진 객체만 사용하므로 데이터의 일관성을 보장함
- 제한된 인스턴스 생성 : 사전에 정의된 인스턴스만 생성하고 외부에서는 이 인스턴스만 사용하도록 함
- 타입 안전성 : 컴파일 시점에서 오류 확인이 가능함
<br>

### 4. 열거형 - Enum Type
#### 자바의 열거형이란?
>타입 안전 열거형 패턴(Type-Safe Enum Pattern)을 쉽게 사용할 수 있도록 프로그래밍 언어에서 지원하는 것    
>###### enumeration(enum) : 코드 내에서 미리 정의된 집합

#### 타입 안전 열거형 패턴과 열거형
- 타입 안전 열거형 패턴
```
public class Grade {
    public static final ClassGrade BASIC = new ClassGrade();
    public static final ClassGrade GOLD = new ClassGrade();
    public static final ClassGrade DIAMOND = new ClassGrade();
}
```
- 열거형 (Enum Type)
```
public enum Grade {
    BASIC, GOLD, DIAMOND
}
```
<br>

#### 열거형의 장점
- 타입 안전성 향상 : 유효하지 않은 값이 입력될 가능성이 없음, **컴파일 오류 발생**
- 간결성 및 일관성 : 코드가 더 간결하고 명확해지며, 데이터의 일관성이 보장됨 
- 확장성 : 새로운 타입을 추가하고싶다면, ENUM에 새로운 상수를 추가하기만하면 됨
<br>

### 5. 열거형 - 주요 메서드
| 메서드                  | 기능                  |
|:---------------------|:--------------------|
| **values()**         | **모든 상수 반환**        |
| ValueOf(String name) | 주어진 이름과 일치하는 상수 반환  |
| name()               | 상수의 이름을 문자열로 반환     |
| ordinal()            | 상수의 선언순서(0부터 시작) 반환 |
| toString()           | 상수의 이름을 문자열로 반환     |
<br>

### 열거형 - 리팩토링1
### 열거형 - 리팩토링2
### 열거형 - 리팩토링3
