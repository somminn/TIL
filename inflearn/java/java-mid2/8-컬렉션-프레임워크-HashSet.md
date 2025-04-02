## 섹션 8. 컬렉션 프레임워크 - HashSet

### 1. 직접 구현하는 Set1 - MyHashSetV1
`Set은 중복을 허용하지 않고, 순서를 보장하지 않는 자료 구조이다.`

- buckets : 연결 리스트를 배열로 사용한다.
  - 열안에 연결 리스트가 들어있고, 연결 리스트 안에 데이터가 저장된다.
  - 해시 인덱스가 충돌이 발생하면 같은 연결 리스트 안에 여러 데이터가 저장된다.

#### add(value)
셋에 값을 추가한다. 중복 데이터는 저장하지 않는다.
```java
public boolean add(int value) {  // capacity 지정 가능
        int hashIndex = hashIndex(value);  // 해시인덱스 생성
        LinkedList<Integer> bucket = buckets[hashIndex]; // 해시인덱스로 링크드리스트 꺼내기
        if (bucket.contains(value)) {
            return false; 
        } // 해당 데이터가 있다면 false 반환하고 나오기
        bucket.add(value); // 리스트에 데이터 추가
        size++;
        return true;
}
```

#### contains(value)
셋에 값이 있는지 확인한다.
```java
public boolean contains(int searchValue) {
        int hashIndex = hashIndex(searchValue); // 해시인덱스 생성
        LinkedList<Integer> bucket = buckets[hashIndex]; // 헤시인덱스로 링크드리스트 꺼내기
        return bucket.contains(searchValue); // 찾으려는 데이터가 있으면 true, 없으면 false 반환
}
```

#### remove(value)
셋에 있는 값을 제거한다.
```java
public boolean remove(int value) {
        int hashIndex = hashIndex(value); // 해시인덱스 생성
        LinkedList<Integer> bucket = buckets[hashIndex]; // 헤시인덱스로 링크드리스트 꺼내기
        if(!bucket.contains(value)) {
            return false;
        } // 해당 데이터가 없다면 false 반환하고 나오기
        bucket.remove(Integer.valueOf(value)); // 해당 데이터를 가진 Integer 인스턴스 제거
        size--;
        return true;
}
```

### 2. 문자열 해시 코드

#### ASCII 코드표
ASCII 코드 표를 참고해 문자 데이터를 숫자로 변환한다.

![Image](https://github.com/user-attachments/assets/40779229-3eab-4744-b88e-21ed5b2d462a)

#### 문자열이 숫자가 되는 과정
```java
// char
char charA = 'A';

// hashCode
System.out.println("hashCode(A) = " + hashCode("A")); // 65

// hashIndex
System.out.println("hashIndex(A) = " + hashIndex(hashCode("A"))); // 5
```
![해시 코드와 해시 인덱스](https://github.com/user-attachments/assets/9f3f5263-95b7-4557-84aa-54dc56a9d6b1)
1. hashCode() 메서드를 사용해 문자열을 해시 코드로 변환한다.
2. 숫자 값인 해시 코드를 사용해서 해시 인덱스를 생성한다.
3. 해시 인덱스를 배열의 인덱스로 사용한다.

#### 해시 함수
해시 함수는 임의의 길이의 데이터를 입력으로 받아, 고정된 길이의 해시값(해시 코드)을 출력하는 함수이다.
- 같은 데이터를 입력하면 항상 같은 해시 코드가 출력된다.
- 다른 데이터를 입력해도 같은 해시 코드가 출력될 수 있다. 이것을 해시 충돌이라 한다.

##### hashCode()
```java
static int hashCode(String str) {
        char[] charArray = str.toCharArray();  // 문자열 str을 char 타입의 배열로 변환 (char은 문자 하나만 취급)
        int sum = 0;
        for (char c : charArray) {
            sum += (int) c; // char 타입을 int 로 캐스팅 
        }
        return sum; 
}
```

#### 해시 코드

해시 코드는 데이터를 대표하는 값을 뜻한다. 보통 해시 함수를 통해 만들어진다.
- 데이터 `A` 의 해시 코드는 `65`
- 데이터 `B` 의 해시 코드는 `66`
- 데이터 `AB` 의 해시 코드는 `131` (65 + 66)

#### 해시 인덱스
해시 인덱스는 데이터의 저장 위치를 결정하는데, 주로 해시 코드를 사용해서 만든다.
- 보통 해시 코드의 결과에 배열의 크기를 나누어 구한다.


### 3. 자바의 hashCode()
모든 타입을 해시 자료 구조에 저장하려면 모든 객체가 숫자 해시 코드를 제공할 수 있어야 한다.

#### Object.hashCode()
자바는 모든 객체가 자신만의 해시 코드를 표현할 수 있게 Object.hashCode() 메서드를 제공한다.
  - 보통 재정의(오버라이딩)해서 사용한다.
  - 기본 구현은 객체의 참조값을 기반으로 해시 코드를 생성한다.

#### Object 의 해시 코드 비교
```java
Object obj1 = new Object();
Object obj2 = new Object();
System.out.println("obj1.hashCode() = " + obj1.hashCode()); // obj1.hashCode() = 762218386
System.out.println("obj2.hashCode() = " + obj2.hashCode()); // obj2.hashCode() = 796533847
```
Object 가 기본으로 제공하는 hashCode() 는 객체의 참조값을 해시 코드로 사용한다.  
따라서 각각의 인스턴스마다 서로 다른 값을 반환한다.

#### 자바의 기본 클래스의 해시 코드
Integer , String 같은 자바의 기본 클래스들은 대부분 내부 값을 기반으로 해시 코드를 구할 수 있도록 hashCode() 메서드를 재정의하였다.  
따라서 데이터의 값이 같으면 같은 해시 코드를 반환한다.

#### 동일성과 동등성
- 동일성(Identity): `==` 연산자를 사용해서 두 객체의 참조가 동일한 객체를 가리키고 있는지 확인
- 동등성(Equality): `equals()` 메서드를 사용하여 두 객체가 논리적으로 동등한지 확인

#### 내가 만든 객체
hashCode() 를 재정의하지 않으면 Object 가 기본으로 제공하는 hashCode()를 사용한다.   
Object.hashCode()는 객체의 참조값을 기반으로 해시 코드를 제공하므로 주의해야한다.

Member 의 경우 회원의 id 가 같으면 논리적으로 같은 회원으로 표현할 수 있다.  
따라서 회원 id를 기반으로 동등성을 비교하도록 `equals` 를 재정의해야 한다.

`equals` 와 `hashCode` 를 같이 재정의하는 이유이다.
```java
@Override
public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) {
        return false;
    }
    Member member = (Member) o;
    return Objects.equals(id, member.id);
}

@Override
public int hashCode() {
    return Objects.hashCode(id);
}
```

```java
Member member1 = new Member("idA");
Member member2 = new Member("idA");

System.out.println("(member1 == member2) = " + (member1 == member2)); // false
System.out.println("member1 equals member2 = " + member1.equals(member2)); // true
```

#### 4. 직접 구현하는 Set2 - MyHashSetV2
MyHashSetV1 은 Integer 숫자만 저장할 수 있었다. 모든 타입을 저장할 수 있는 Set 을 만들어보자.

```java
private LinkedList<Object>[] buckets
```
- 모든 타입을 저장할 수 있도록 Object 를 사용한다.
- 저장, 검색, 삭제 메서드의 매개변수도 Object 로 변경했다.

```java
private int hashIndex(Object value) {
    return Math.abs(value.hashCode()) % capacity; // 음수가 나올 수 없게 절댓값 처리
}
```
- Object 의 hashCode() 를 사용해 해시 코드를 구한다. (다형성에 의해)
- 음수는 배열의 인덱스가 될 수 없으니 Math.abs() 를 사용해 양수를 얻는다.

![Object.hashCode()](https://github.com/user-attachments/assets/7dc9f95f-1860-4b8a-843b-ccdf1a9df258)


### 5. 직접 구현하는 Set3 - 직접 만든 객체 보관
set 에 직접 만든 객체 보관할 때는 객체의 equals 와 hashCode() 두 메서드를 반드시 재정의 해야한다.  
`Member` 의 경우 회원의 id로 동등성을 비교하므로 equals 와 hashCode() 둘 다 id를 기반으로 재정의했다.

![set에 직접 만든 객체 보관](https://github.com/user-attachments/assets/52eb3eb7-1fa5-4928-9f4e-f75d3b20fbd5)

#### equals() 사용처
해시 인덱스가 충돌하여 연결 리스트에서 데이터를 하나하나 비교해야 할 때, equals 메서드를 사용한다.  
따라서 해시 자료 구조를 사용할 때는 hashCode()와 equals()를 반드시 재정의해야 한다.



### 6. equals, hashCode 의 중요성1
hashCode() , equals() 를 제대로 구현하지 않으면 어떤 문제가 발생하는지 알아보자.

#### Object 의 기본 기능
- hashCode() : 객체의 참조값을 기반으로 해시 코드를 반환한다.
- equals() : 객체의 참조값이 같으면 true 를 반환한다. (`==` 동등성 비교)

1. hashCode, equals 모두 구현하지 않은 경우 
2. hashCode 는 구현했지만 equals 를 구현하지 않은 경우 
3. hashCode 와 equals 를 모두 구현한 경우

#### hashCode, equals 모두 구현하지 않은 경우
hashCode() , equals() 를 재정의하지 않아서 Object 의 기본 기능을 사용한다.

```java
MyHashSetV2 set = new MyHashSetV2(10);
MemberNoHashNoEq m1 = new MemberNoHashNoEq("A");
MemberNoHashNoEq m2 = new MemberNoHashNoEq("A");
System.out.println("m1.hashCode() = " + m1.hashCode()); // m1.hashCode() = 1004 
System.out.println("m2.hashCode() = " + m2.hashCode()); // m2.hashCode() = 1007
System.out.println("m1.equals(m2) = " + m1.equals(m2));  // m1.equals(m2) = false
```
m1 과 m2는 다른 객체이기 떄문에 같은 id 여도 다른 해시코드를 생성한다.

- 데이터 저장 문제
```java
set.add(m1);
set.add(m2);
```
![Image](https://github.com/user-attachments/assets/daa832f1-1e13-4bb4-8d41-d92b3bd72fed)

m1 과 m2 의 해시코드는 서로 다르기 때문에 다른 위치에 각각 저장된다.  
회원 id가 "A"로 같은 회원의 데이터가 중복으로 저장된다.

- 데이터 검색 문제
```java
MemberNoHashNoEq searchValue = new MemberNoHashNoEq("A");
System.out.println("searchValue.hashCode() = " + searchValue.hashCode()); // earchValue.hashCode() = 1008
boolean contains = set.contains(searchValue);
System.out.println("contains = " + contains); // contains = false
```
![Image](https://github.com/user-attachments/assets/658abdb3-3ebb-4be7-8a87-a85bee10c559)

회원 id가 "A"인 객체를 검색하기 위해 회원 id가 "A"인 객체를 만들었다.
검색을 위해 만든 searchValue 도 다른 참조값을 가졌기 떄문에 다른 위치에서 데이터를 찾게 되고, 검색에 실패한다.


### 7. equals, hashCode 의 중요성2

#### hashCode 는 구현했지만 equals 를 구현하지 않은 경우
```java
@Override
public int hashCode() {
    return Objects.hash(id);
}
```
```java
MyHashSetV2 set = new MyHashSetV2(10);
MemberOnlyHash m1 = new MemberOnlyHash("A");
MemberOnlyHash m2 = new MemberOnlyHash("A");
System.out.println("m1.hashCode() = " + m1.hashCode());
System.out.println("m2.hashCode() = " + m2.hashCode());
```
```java
m1.hashCode() = 96
m2.hashCode() = 96
m1.equals(m2) = false
MyHashSetV2{buckets=[[], [], [], [], [], [], [MemberOnlyHash{id='A'}, MemberOnlyHash{id='A'}], [], [], []], size=2, capacity=10}
searchValue.hashCode() = 96
contains = false
```

- 데이터 저장 문제  
hashCode() 를 재정의했기 때문에 같은 id 를 사용하는 m1 , m2 는 같은 해시 코드를 사용한다.  
그런데 add() 로직은 equals() 를 사용하여 중복 데이터를 확인하기 때문에 참조값이 다른 두 객체는 중복 저장된다.

- 데이터 검색 문제  
searchValue 도 m1, m2 와 같은 해시 코드를 받기 때문에 같은 해시 인덱스까지는 도달한다.  
하지만 해시 인덱스에 있는 모든 데이터를 equals() 를 통해 참조값 비교를 하기때문에 검색에 실패한다.

#### hashCode 와 equals 를 모두 구현한 경우
- 데이터 저장

![Image](https://github.com/user-attachments/assets/7bdcf7be-026e-42e2-b12a-9d5c78306ffa)
중복 데이터를 저장하면 안되므로 add() 로직에서 m1 과 m2 를 equals 비교한다.  
m2 는 m1의 중복 데이터이기 때문에 저장에 실패한다.

- 데이터 검색

![Image](https://github.com/user-attachments/assets/de722b43-0de0-4f40-8e7a-9ef18f57d232)
searchValue 와 m1 이 equals 비교에 성공하므로 참을 반환한다.


### 8. 직접 구현하는 Set4 - 제네릭과 인터페이스 도입

#### MySet 인터페이스
```java
public interface MySet<E> {
    boolean add(E element);
    boolean remove(E value);
    boolean contains(E value);
}
```
핵심 기능을 인터페이스로 뽑았다. 이 인터페이스를 구현하면 해시 기반이 아니라 다른 자료 구조 기반의 Set도 만들 수 있다.

#### 제네릭 도입
```java
public class MyHashSetV3<E> implements MySet<E>
```
제네릭의 덕분에 타입 안전성이 높은 자료 구조를 만들 수 있었다.

### 메모
Math.abs(value) : 절댓값 처리

System.identityHashCode(value) : value 의 참조값 출력