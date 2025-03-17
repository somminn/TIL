## 섹션 2. 제네릭 - Generic1

### 1. 제네릭이 필요한 이유
데이터 타입마다 set() get() 기능이 있는 데이터 박스를 만들었다.
```
public class BoxMain1 {
        IntegerBox integerBox = new IntegerBox();
        integerBox.set(10); // 오토 박싱
        Integer integer = integerBox.get();
    }
}
```

### 2. 다형성을 통한 중복 해결 시도
Object 는 모든 타입의 부모이다. 따라서 다형성(다형적 참조)을 사용해서 중복을 줄였다.
```
public class BoxMain2 {
        ObjectBox integerBox = new ObjectBox();
        integerBox.set(10);
        Integer integer = (Integer) integerBox.get(); // Object -> Integer 다운캐스팅
    }
}
```
#### 문제점
1. 반환 타입이 맞지 않음 : 반환 타입을 Object 에서 각 타입으로 다운캐스팅해야한다.
2. 잘못된 타입의 인수 전달 : set() 메서드는 모든 타입의 부모인 Object 를 매개변수로 받기 때문에 세상의 어떤 데이터도 입력받을 수 있다.

#### BoxMain1 vs BoxMain2
|  Box   |      BoxMain1      |              BoxMain2              | **Generic** |
|:------:|:------------------:|:----------------------------------:|:-----------:|
| 클래스 정의 | 각각의 타입별로 클래스 모두 정의 | ObjectBox 를 사용해서 다형성으로 하나의 클래스만 정의 |             |
| 코드 재사용 |         X          |                 O                  |      O      |
| 타입 안정성 |         O          |                 X                  |      O      |


### 3. 제네릭 적용
`제네릭을 사용하면 코드 재사용과 타입 안정성 둘 다 보장할 수 있다!`

#### 제네릭 사용 예제
```
public class GenericBox<T> {
        private T value;
        
        public void set(T value) {
            this.value = value;
        }
        
        public T get() {
            return value;
        }
}
```
- <> (다이아몬드) 를 사용한 클래스를 제네릭 클래스라 한다.
- T 를 **타입 매개변수**라 한다. 이 타입 매개변수는 이후에 다른 데이터 타입으로 변경할 수 있다.
```
GenericBox<Integer> integerBox = new GenericBox<Integer>(); // 생성 시점에 T의 타입 결정
        integerBox.set(10);
        // integerBox.set("문자100"); // Integer 타입만 허용, 컴파일 오류
        Integer integer = integerBox.get(); // Integer 타입 반환 (캐스팅 필요 없음)
```
- 제네릭 클래스는 생성하는 시점에 <> 사이에 원하는 타입을 지정한다.
- 이제 set(Integer value) 이므로 이 메서드에는 Integer 타입만 담을 수 있다.
- get()의 경우에도 타입 캐스팅 없이 숫자 타입으로 조회할 수 있다.

#### 타입 추론
`생성하는 제네릭의 타입을 생략할 수 있다!`
```
GenericBox<Integer> integerBox2 = new GenericBox<Integer>(); // 타입 직접 입력
GenericBox<Integer> integerBox2 = new GenericBox<>(); // 타입 추론
```

### 4. 제네릭 용어와 관례
`제네릭의 핵심은 사용할 타입을 미리 결정하지 않는다는 점이다!`  
이것을 쉽게 비유하자면 메서드의 매개변수와 인자의 관계와 비슷하다.

#### 참고) 메서드의 매개변수와 인자
```
void method(String param) // 매개변수
  
void main() {
    String arg = "hello";
    method(arg); // 인수 전달
}
```
- 매개변수(Parameter): String param
- 인자, 인수(Argument): arg

#### 제네릭의 타입 매개변수와 타입 인자
> 제네릭 클래스를 정의할 때 내부에서 사용할 타입을 미리 결정하는 것이 아니라, 해당 클래스를 실제 사용하는 생성 시 점에 내부에서 사용할 타입을 결정하는 것이다. 
메서드와 차이가 있다면 메서드의 매개변수는 사용할 값에 대한 결정을 나중으로 미루는 것이고, 제네릭의 타입 매개변수는 사용할 타입에 대한 결정을 나중으로 미루는 것이다.

|      |               Method                |              Generic               | 
|:----:|:-----------------------------------:|:----------------------------------:|
| 미루다  | 메서드의 매개변수는 사용할 값에 대한 결정을 나중으로 미루는 것 | 타입 매개변수는 사용할 타입에 대한 결정을 나중으로 미루는 것 |         |
| 결정하다 |      매개변에 인자를 전달해서 사용할 값을 결정함       |  타입 매개변수에 타입 인자를 전달해서 사용할 타입을 결정함  | 
|  용어  |              매개변수와 인자               |           타입 매개변수와 타입 인자           | 


#### 제네릭 용어 정리
- 제네릭(Generic) 단어
  - 제네릭이란 일반적인, 범용적인 이라는 영어 단어 뜻이다.
- 제네릭 타입 (Generic Type)
  - 제네릭 클래스 + 제네릭 인터페이스
    - 타입은 클래스, 인터페이스, 기본형(int 등)을 모두 합쳐서 부르는 말이다.
  - `public class GenericBox<T>` 에서 GenericBox<T>
- 타입 매개변수
  - 제네릭 타입이나 메서드에서 사용되는 변수로, 실제 타입으로 대체된다.
  - `public class GenericBox<T>` 에서 T
- 타입 인자 
  - 제네릭 타입을 사용할 때 제공되는 실제 타입이다.
  - `GenericBox<Integer> integerBox = new GenericBox<Integer>();` 에서 Integer
  - 타입 인자로 기본형은 사용할 수 없다.

#### 제네릭 명명 관례
- E - Element
- K - Key
- N - Number
- T - Type
- V - Value
- S,U,V etc. - 2nd, 3rd, 4th types

#### 제네릭 기타
다음과 같이 한번에 여러 타입 매개변수를 선언할 수 있다.
`class Data<K, V> {}`

#### row 타입
`과거에 Object 제네릭 대신 사용하던 것이니 지양하자!`


### 5. 제네릭 활용 예제





### 메모
오토박싱

매개변수와 인자