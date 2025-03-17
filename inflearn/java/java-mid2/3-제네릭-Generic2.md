## 섹션 3. 제네릭 - Generic2

### 1. 타입 매개변수 제한1 - 시작
요구사항: 개 병원은 개만 받을 수 있고, 고양이 병원은 고양이만 받을 수 있어야 한다.
```java
DogHospital dogHospital = new DogHospital();
CatHospital catHospital = new CatHospital();

// 문제1: 개 병원에 고양이 전달
// dogHospital.set(cat); // 다른 타입을 입력 : 컴파일 오류 -> 타입 안정성 O

// 문제2: 개 타입 반환
dogHospital.set(dog);
Dog biggerDog = dogHospital.bigger(new Dog("멍멍이2", 200));
System.out.println("biggerDog = " + biggerDog);
```
- 코드 재사용 X: 개 병원과 고양이 병원은 중복이 많이 보인다. 
- 타입 안전성 O: 타입 안전성이 명확하게 지켜진다.

### 2. 타입 매개변수 제한2 - 다형성 시도
요구사항 : 중복을 없애고 코드 재사용성을 높여라
```java
AnimalHospitalV1 dogHospital = new AnimalHospitalV1();
AnimalHospitalV1 catHospital = new AnimalHospitalV1();

// 문제1: 개 병원에 고양이 전달
dogHospital.set(cat); // 매개변수 체크 실패 : 컴파일 오류가 발생하지 않음 -> 타입 안정성 X

// 문제2: 개 타입 반환, 캐스팅 필요
dogHospital.set(dog);
Dog biggerDog = (Dog) dogHospital.bigger(new Dog("멍멍이2", 200));
System.out.println("biggerDog = " + biggerDog);
```
- 코드 재사용 O: 다형성을 통해 AnimalHospitalV1 하나로 개와 고양이를 모두 처리한다. 
- 타입 안전성 X
  - 개 병원에 고양이를 전달하는 문제가 발생한다.
  - Animal 타입을 반환하기 때문에 다운 캐스팅을 해야 한다.

### 3. 타입 매개변수 제한3 - 제네릭 도입과 실패
요구사항 : 제네릭 도입
```java
public class AnimalHospitalV2<T> {
    private T animal;
}
```
- 문제
  - 제네릭에서 타입 매개변수를 사용하면 어떤 타입이든 들어올 수 있다.
  - T 의 타입을 메서드를 정의하는 시점에는 알 수 없다. Object 기능만 사용

### 4. 타입 매개변수 제한4 - 타입 매개변수 제한
요구사항 : 타입 인자로 Animal 과 그 자식만 들어올 수 있게 제한하라
```java
public class AnimalHospitalV3 <T extends Animal>

// 문제1: 개 병원에 고양이 전달
// dogHospital.set(cat); // 다른 타입 입력 : 컴파일 오류

// 문제2: 개 타입 반환, 명시적 캐스팅 안해도 됨
dogHospital.set(dog);
Dog biggerDog = dogHospital.bigger(new Dog("멍멍이2", 200));
System.out.println("biggerDog = " + biggerDog);
```
- 타입 매개변수 T를 Animal 과 그 자식만 받을 수 있도록 제한을 둔다. 즉, T의 상한이 Animal 이 되는 것이다.

#### 기존 문제와 해결
- 타입 안정성 X 문제 : 다른 타입 입력 문제, 다운캐스팅 문제, 캐스팅 예외 문제 해결
- 제네릭 도입 문제 : 타입 매개변수 제한 불가 문제 해결

`제네릭에 타입 매개변수 상한을 사용해서 타입 안정성을 지키면서 상위 타입의 원하는 기능까지 사용할 수 있게 됐다. 코드 재상용과 타입 안정성이라는 두 마리 토끼를 동시에 잡을 수 있었다.`



### 5. 제네릭 메서드
`제네릭 타입과 제네릭 메서드는 다른 것!` 
```java
public static <T> T genericMethod (T t) {
      System.out.println("Generic print: " + t);
      return t;
  }
```

#### 제네릭 타입과 제네릭 메서드
|          |                  제네릭 타입                   |                          제네릭 메서드                          |
|:--------:|:-----------------------------------------:|:---------------------------------------------------------:|
|  적용 범위   |                  클래스 전체                   |                          특정 메서드                           |
|    정의    |              GenericClass<T>              |                 <T> T genericMethod(T t)                  |
| 타입 인자 전달 | 객체 생성 시점<br/>ex) new GenericClass<String> | 메서드 호출 시점<br/>ex) GenericMethod.<Integer>genericMethod(i) |

#### 타입 매개변수 제한
제네릭 메서드도 제네릭 타입과 마찬가지로 타입 매개변수를 제한할 수 있다.

```java
public static <T extends Number> T numberMethod(T t) {
    System.out.println("Bound print: " + t);
    return t;
}
```

#### 제네릭 메서드 타입 추론
자바 컴파일러는 genericMethod() 에 전달되는 인자 i의 타입이 Integer 라는 것을 알고있어 생략이 가능하다.
```java
Integer i = 10;

// 타입 인자(Type Argument) 명시적 전달
Integer result = GenericMethod.<Integer>genericMethod(i);

// 타입 추론
Integer result2 = GenericMethod.genericMethod(i);
```


### 6. 제네릭 메서드 활용
#### 제네릭 타입과 제네릭 메서드의 우선순위
`제네릭 타입보다 제네릭 메서드가 높은 우선순위를 가진다!`

```java
public class ComplexBox < T extends Animal> {

    private T animal;

    public void set(T animal) {
        this.animal = animal;
    }

    public <Z> Z printAndReturn(Z z) {
      System.out.println("animal.className: " + animal.getClass().getName());
      System.out.println("t.className: " + z.getClass().getName());
      return z;
    }
}
```

- 제네릭 타입 설정  
`class ComplexBox < T extends Animal>`
- 제네릭 메서드 설정   
`public <Z> Z printAndReturn(Z z)`

제네릭 타입보다 제네릭 메서드가 높은 우선순위를 가진다. 
따라서 printAndReturn() 은 제네릭 타입과는 무관하고 제네릭 메서드가 적용된다.
여기서 적용된 제네릭 메서드의 타입 매개변수 T 는 상한이 없다. 따라서 Object 로 취급된다.


### 7. 와일드카드1
`와일드카드는 제네릭 타입이나, 제네릭 메서드를 선언하는 것이 아니다. 와일드카드는 이미 만들어진 제네릭 타입을 활용할 때 사용한다.`

#### 비제한 와일드카드 
`비제한 와일드카드 : ? 만 사용해서 제한 없이 모든 타입을 다 받을 수 있는 와일드카드`
```java
// 와일드카드
static void printWildcardV1(Box<?> box) {
    System.out.println("? = " + box.get());
}      

// 제네릭
static <T> void printGenericV1(Box<T> box) {
    System.out.println("T = " + box.get());     
}
```
와일드카드는 제네릭 타입이나 제네릭 메서드를 정의할 때 사용하는 것이 아니다. `Box<Dog>` , `Box<Cat>` 처럼 타입 인자가 정해진 제네릭 타입을 전달 받아서 활용할 때 사용한다.


##### 제네릭 메서드 vs 와일드카드
>printGenericV1() 제네릭 메서드를 보자. 제네릭 메서드에는 타입 매개변수가 존재한다. 그리고 특정 시점에 타입
매개변수에 타입 인자를 전달해서 타입을 결정해야 한다. 이런 과정은 매우 복잡하다.
반면에 printWildcardV1() 메서드를 보자. 와일드카드는 일반적인 메서드에 사용할 수 있고, 단순히 매개변수로 제네릭 타입을 받을 수 있는 것 뿐이다. 제네릭 메서드처럼 타입을 결정하거나 복잡하게 작동하지 않는다. 단순히 일반 메서드에 제네릭 타입을 받을 수 있는 매개변수가 하나 있는 것 뿐이다.
제네릭 타입이나 제네릭 메서드를 정의하는게 꼭 필요한 상황이 아니라면, 더 단순한 와일드카드 사용을 권장한다.


### 8. 와일드카드2

#### 상한 와일드카드
제네릭 메서드와 마찬가지로 와일드카드에도 상한 제한을 둘 수 있다.
```java
// 와일드카드
static void printWildcardV2 (Box<? extends Animal> box) {
    Animal animal = box.get();
    System.out.println("이름 = " + animal.getName());
}

// 제네릭
static <T extends Animal> void printGenericV2(Box<T> box) {
    T t = box.get();
    System.out.println("이름 = " + t.getName());
}
```

#### 타입 매개변수가 꼭 필요한 경우
`제네릭 타입이나 제네릭 메서드가 꼭 필요한 상황이면 <T> 를 사용하고, 그렇지 않은 상황이면 와일드카드를 사용하는 것을 권장한다.`
```java
// 와일드카드
static Animal printAndReturnWildcardV3 (Box<? extends Animal> box) {
        Animal animal = box.get();
        System.out.println("이름 = " + animal.getName());
        return animal;
    }
    
// 제네릭    
static <T extends Animal> T printAndReturnGenericV3(Box<T> box) {
        T t = box.get();
        System.out.println("이름 = " + t.getName());
        return t;
    }
```
`와일드카드 메서드는 전달한 타입을 명확하게 반환할 수 없다.`
와일드카드는 이미 만들어진 제네릭 타입을 전달 받아서 활용할 때 사용한다. 따라서 메서드의 타입들을 타입 인자를 통 해 변경할 수 없다. 쉽게 이야기해서 일반적인 메서드에 사용한다고 생각하면 된다.
```java
Animal animal = WildcardEx.printAndReturnWildcard(dogBox);
```

`반면, 제네릭 메서드는 전달한 타입을 명확하게 반환할 수 있다.` 
```java
Dog dog = WildcardEx.printAndReturnGeneric(dogBox);
```


#### 하한 와일드 카드
```java
static void writeBox (Box<? super Animal> box) {
        box.set(new Dog("멍멍이",100));
    }
```
Animal 타입을 포함한 Animal 타입의 상위 타입만 입력 받을 수 있다는 뜻이다.
제네릭은 위 기능이 없다.



### 9. 타입 이레이저
`자바의 제네릭 타입은 컴파일 시점에만 존재하고, 런타임 시에는 제네릭 정보가 지워지는데, 이것을 타입 이레이저라 한다.`

컴파일 이후에는 제네릭의 타입 정보가 존재하지 않는다. .class 로 자바를 실행하는 런타임에는 우리가 지정한 타입 정보가 모두 제거된다.
따라서 런타임에 타입을 활용하는 코드는 작성할 수 없다.





### 메모 
삼항 연산자