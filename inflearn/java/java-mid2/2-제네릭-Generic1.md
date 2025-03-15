## 섹션2. 제네릭 - Generic1

### 1. 제네릭이 필요한 이유
데이터를 set()하고 get()하는 박스가 있을 때, 모든 데이터 타입의 박스를 만들어야할까?
ex) IntegerBox, StringBox

### 2. 다형성을 통한 중복 해결 시도
Object 는 모든 타입의 부모이다. 따라서 다형성(다형적 참조)를 사용해서 해결해보자.

문제 1. 반환 타입이 맞지 않음 
반환 타입을 Object 에서 각 타입으로 다운캐스팅해야한다.
`Object obj = integerBox.get();
Integer integer = (Integer) integerBox.get();`

문제 2. 잘못된 타입의 인수 전달
 


### 3. 제네릭 적용
### 4. 제네릭 용어와 관례
### 5. 제네릭 활용 예제
