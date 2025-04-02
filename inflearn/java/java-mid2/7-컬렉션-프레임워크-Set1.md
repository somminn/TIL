## 섹션 6. 컬렉션 프레임워크 - Set1

### 1. 리스트 vs 세트

#### List (리스트)
![리스트](https://github.com/user-attachments/assets/e0a10280-631e-4d17-a449-07381587dd4a)
- 정의: 리스트는 요소들의 순차적인 컬렉션이다. 요소들은 특정 순서를 가지며, 같은 요소가 여러 번 나타날 수 있다.
- 특징 
  - 순서 유지: 리스트에 추가된 요소는 특정한 순서를 유지한다.
  - 중복 허용: 리스트는 동일한 값이나 객체의 중복을 허용한다.
  - 인덱스 접근: 리스트의 각 요소는 인덱스를 통해 접근할 수 있다.
- 용도: 순서가 중요하거나 중복된 요소를 허용해야 하는 경우에 주로 사용된다.
- 예시: 장바구니 목록, 순서가 중요한 일련의 이벤트 목록.

#### Set(세트)
![세트](https://github.com/user-attachments/assets/f4aca55e-f5ee-4eaf-8d68-e1488271de49)
- 정의: 세트(셋)는 유일한 요소들의 컬렉션이다.
- 특징
  - 유일성: 셋에는 중복된 요소가 존재하지 않는다.
  - 순서 미보장: 대부분의 셋 구현에서는 요소들의 순서를 보장하지 않는다.
  - 빠른 검색: 셋은 요소의 유무를 빠르게 확인할 수 있도록 최적화되어 있다.
- 용도: 중복을 허용하지 않고, 요소의 유무만 중요한 경우에 사용된다.
- 예시: 회원 ID 집합, 고유한 항목의 집합.


### 2. 직접 구현하는 Set0 - 시작
 #### add(value) - O(n)
Set 에 중복된 값이 있는지 체크하고 중복된 값이 있으면 false, 중복된 값이 없으면 값을 저장하고 true 를 반환한다. 
```java
public boolean add(int value) {
      if (contains(value)) {
          return false;
      }
      elementData[size] = value;
      size++;
      return true;
}
```

#### contains(value) - O(n)
Set 에 값이 있으면 true 를 반환하고, 값이 없으면 false 를 반환한다.  
알아서 루프로 돌려줌
```java
public boolean contains(int value) {
      for (int data : elementData) {
          if(data == value) {
              return true;
          }
      }
      return false;
}
```

### 3. 해시 알고리즘1 - 시작
배열에서 특정 데이터를 찾는 성능은 O(n)으로 느리다.


### 4. 해시 알고리즘2 - index 사용
데이터의 값 자체를 배열의 인덱스로 사용하니 O(n)의 검색 성능이 O(1)로 개선됐다.
```java
Integer[] inputArray = new Integer[10];
inputArray[1] = 1;
inputArray[2] = 2;
inputArray[5] = 5;
inputArray[8] = 8;
```

### 5. 해시 알고리즘3 - 메모리 낭비
데이터의 값 자체를 배열의 인덱스로 사용하면 검색 속도는 빠르지만 입력 값의 범위가 조금만 커져도 메모리 낭비가 너무 심해진다.

### 6. 해시 알고리즘4 - 나머지 연산
나머지 연산을 사용히면 공간도 절약하면서, 넓은 범위의 값을 사용할 수 있다.   
배열의 크기(CAPACITY)를 10이라고 가정했을 때 나머지 연산의 결과는 절대로 10이 되거나 10을 넘지 않는다.

![해시-나머지연산](https://github.com/user-attachments/assets/ab98db3a-dba5-43ec-ba5e-9e9931b12ca4)

#### hashIndex()
입력 값을 배열의 크기로 나머지 연산해서 해시 인덱스를 반환한다.
```java
static int hashIndex(int value) {
        return value % CAPACITY; 
}
```

#### 데이터 저장 - O(1)
1. 저장할 값의 해시 인덱스를 구한다.
2. 해시 인덱스를 배열의 인덱스로 사용해서 데이터를 저장한다.   
   ex) `inputArray[hashIndex] = value`

#### 데이터 조회 - O(1)
1. 조회할 값의 해시 인덱스를 구한다.
2. 해시 인덱스를 배열의 인덱스로 사용해서 데이터를 조회한다.  
   ex) `int value = inputArray[hashIndex]`

#### 한계 - 해시 충돌
그런데 지금까지 설명한 내용은 저장할 위치가 충돌할 수 있다는 한계가 있다.
   
### 7. 해시 알고리즘5 - 해시 충돌 설명
#### 해시 충돌 
99, 9의 두 값은 10으로 나누면 9가 된다. 따라서 다른 값을 입력했지만 같은 해시 코드가 나오게 되는데 이것을 해시 충돌이라 한다.

![해시충돌](https://github.com/user-attachments/assets/c69f0c80-3711-4a11-bbaf-462091dd0e62)

#### 해시 충돌 해결
해시 충돌이 일어났을 때 배열 안에 배열을 만들어 해시 인덱스가 같은 값들을 함께 저장한다.

#### 해시 충돌과 조회
1. 해시 인덱스를 배열의 인덱스로 사용해서 데이터를 조회한다.
2. 배열 안에는 또 배열이 들어있다. 여기에 있는 모든 값을 검색할 값과 하나씩 비교한다.


### 8. 해시 알고리즘6 - 해시 충돌 구현
`배열 안에 연결 리스트가 들어있고, 연결 리스트 안에 데이터가 들어가는 구조이다.`

#### 배열 선언
```java
LinkedList<Integer>[] buckets = new LinkedList[CAPACITY]
System.out.println("buckets = " + Arrays.toString(buckets));
```
```java
buckets = [null, null, null, null, null, null, null, null, null, null]
```

#### 연결 리스트 생성
```java
for (int i = 0; i < CAPACITY; i++) {
    buckets[i] = new LinkedList<>();
}
System.out.println("buckets = " + Arrays.toString(buckets));
```
```java
buckets = [[], [], [], [], [], [], [], [], [], []]
```

#### 데이터 등록
1. 해시 인덱스(hashIndex)를 구한다.
2. 해시 인덱스로 배열의 인덱스를 찾는다. 배열에는 연결 리스트가 들어있다.
3. contains() 를 사용해서 중복 여부를 확인하고 같은 데이터가 없다면 저장한다. (Set 은 중복 인정 X)
```java
add(buckets, 1);
add(buckets, 2);
add(buckets, 5);
add(buckets, 8);
add(buckets, 14);
add(buckets, 99);
add(buckets, 9);
System.out.println("buckets = " + Arrays.toString(buckets));

private static void add(LinkedList<Integer>[] buckets, int value) {
    int hashIndex = hashIndex(value); // 1.
    LinkedList<Integer> bucket = buckets[hashIndex]; // O(1) // 2.
    if (!bucket.contains(value)) { 
        bucket.add(value);  
    } // 3.
}
```
```java
buckets = [[], [1], [2], [], [14], [5], [], [], [8], [99, 9]]
```

#### 데이터 검색
1. 해시 인덱스로 배열의 인덱스를 찾는다. 배열에는 연결 리스트가 들어있다.
2. 연결 리스트의 bucket.contains(searchValue) 메서드를 사용해서 데이터를 찾는다.
```java
private static boolean contains(LinkedList<Integer>[] buckets, int searchValue) {
    int hashIndex = hashIndex(searchValue); 
    LinkedList<Integer> bucket = buckets[hashIndex]; // O(1)  // 1.
    return bucket.contains(searchValue); // O(n) // 2.
}
```

#### 해시 인덱스 충돌 확률
통계적으로 입력한 데이터의 수가 배열의 크기를 75% 넘지 않으면 해시 인덱스는 자주 충돌하지 않는다. 반대로 75%를 넘으면 자주 충돌하기 시작한다.








### 메모
- 리턴값은 메서드가 호출된 곳으로 반환되지만, 따로 출력하지 않으면 눈에 보이지 않는다.

- 배열의 크기만큼 출력: Arrays.toString(elementData)
- 데이터가 존재하는 배열까지만 출력 : Arrays.toString(Arrays.copyOf(elementData, size))
