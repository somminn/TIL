## 섹션 10. 컬렉션 프레임워크 - Map, Stack, Queue

### 1. 컬렉션 프레임워크 - Map 소개1
#### Map
![map](https://github.com/user-attachments/assets/a5367b96-fd2d-493b-8639-8f790b46147e)
- 키-값의 쌍을 저장하는 자료 구조
- 키는 중복될 수 없지만, 값은 중복될 수 있다.
- 순서를 유지하지 않는다.

#### 컬렉션 프레임워크 - Map
![map](https://github.com/user-attachments/assets/c0d68f41-def5-4a51-92c3-33e48bcffc43)

#### Map 인터페이스의 주요 메서드
|        메서드        |                     설명                |
|:-----------------:|:-------------------------------------:|
|put(K key, V value)|               지정된 키와 값을 맵에 저장         |
|putIfAbsent(K key, V value)|지정된 키가 없는 경우에 키와 값을 맵에 저장|
|  get(Object key)  |              지정된 키에 연결된 값을 반환         |
|     keySet()      |             맵의 키들을 반환 (Set 형태)        |
|     values()      |          맵의 값들을 반환 (Collection 형태)    |
|    entrySet()     |맵의 키-값 쌍을 <br/>`Set<Map.Entry<K,V>>` 형태로 반환|
|remove(Object key)|지정된 키와 그에 연결된 값 제거|
|containsKey(Object key)| 맵이 지정된 키를 포함하고 있는지 여부 반환|



- #### 키 목록 조회
```java
Map<String, Integer> studentMap = new HashMap<>();
studentMap.put("studentA", 90);
studentMap.put("studentB", 80);
studentMap.put("studentC", 80);
studentMap.put("studentD", 100);
```
```java
Set<String> keySet = studentMap.keySet();
```
Map 은 key 의 중복을 허용하지 않으므로 keySet() 을 호출하면, 중복을 허용하지 않는 자료 구조인 Set 을 반환한다.

- #### 키와 값 목록 조회
```java
Set<Map.Entry<String, Integer>> entries = studentMap.entrySet();
```
Map 에 키와 값으로 데이터를 저장하면 Map 은 내부에서 키와 값을 하나로 묶는 Entry 객체를 만들어서 보관한다.

- #### 값 목록 조회
```java
Collection<Integer> values = studentMap.values();
```
Map은 값 목록은 중복을 허용하고(Set 탈락) 입력 순서를 보장하지 않기 때문에(List 탈락) Collection 으로 반환한다. 


### 2. 컬렉션 프레임워크 - Map 소개2

- #### 특정 값 삭제
Map 의 key 와 value 는 Entry 객체로 묶여있기 때문에 key 만 삭제해도 value 까지 삭제 된다.
```java
studentMap.remove("studentA");
```

- #### 같은 키 + 다른 값 = 값 교체
Map 에 같은 키에 다른 값을 저장하면 기존 값을 교체한다.
```java
Map<String, Integer> studentMap = new HashMap<>();

studentMap.put("studentA", 90);
tudentMap.put("studentA", 100);
System.out.println(studentMap); // {studentA=100}
```

- #### 키가 없는 경우에만 추가
```java
studentMap.put("studentA", 50);
studentMap.putIfAbsent("studentA", 100); // {studentA=50}
studentMap.putIfAbsent("studentB", 100); // {studentB=100}
```
`putIfAbsent(K key, V value)`: key 가 없는 경우에만 value 추가
 


### 3. 컬렉션 프레임워크 - Map 구현체 
Map 은 인터페이스이기 때문에 직접 인스턴스를 생성하지 못한다.
- HashMap
- TreeMap
- LinkedHashMap

#### Map vs Set
`Map` 의 키가 `Set` 과 같은 구조이다.  
`Key` 옆에 `Value` 만 하나 추가해주면 `Map` 이 되는 것이다.

![MapSet](https://github.com/user-attachments/assets/c5e8ad96-5cde-4a04-90cb-fffac2f01a59)

#### HashMap
- 구조: 키 값이 해시 함수를 통해 해시 코드로 변환되고, 이 해시 코드는 데이터를 저장하고 검색하는 데 사용된다.
- 특징: 삽입, 삭제, 검색 작업은 해시 자료 구조를 사용하므로 일반적으로 상수 시간( `O(1)` )의 복잡도를 가진다. 
- 순서: 입력 순서를 보장하지 않는다.

#### LinkedHashMap
- 구조: `HashMap` 과 유사하지만, 연결 리스트를 사용하여 삽입 순서 또는 최근 접근 순서에 따라 요소를 유지한다.
- 특징: 입력 순서에 따라 순회가 가능하다. 입력 순서를 링크로 유지해야 하므로 조금 더 무겁다.
- 성능: `HashMap` 과 유사하게 대부분의 작업은 `O(1)` 의 시간 복잡도를 가진다. 
- 순서: 입력 순서를 보장한다.

#### TreeMap
- 구조: 레드-블랙 트리를 기반으로 한 구현이다.
- 특징: 모든 키는 자연 순서 또는 생성자에 제공된 `Comparator` 에 의해 정렬된다.
- 성능: `get` , `put` , `remove` 와 같은 주요 작업들은 `O(log n)` 의 시간 복잡도를 가진다. 
- 순서: 키 자체의 데이터 값을 기준으로 정렬한다.


### 4. 스택 자료 구조 (사용 안함)
나중에 넣은 것이 가장 먼저 나오는 것을 `후입 선출`이라 하고, 이런 자료 구조를 스택이라 한다.
>1(넣기) -> 2(넣기) -> 3(넣기) -> 3(빼기) -> 2(빼기) -> 1(빼기)

- `push(value)`: 스택에 데이터 넣음
- `peek()`: 다음 꺼낼 데이터 확인
- `pop()`: 스택에서 데이터 꺼내기

### 5. 큐 자료 구조
가장 먼저 넣은 것이 가장 먼저 나오는 것을 `선입 선출`이라 한다. 이런 자료 구조를 큐(Queue)라 한다.
> 1(넣기) -> 2(넣기) -> 3(넣기) -> 1(빼기) -> 2(빼기) -> 3(빼기)

![큐](https://github.com/user-attachments/assets/576b7d60-6f27-410f-96c9-60bf9c4a1a97)

#### 컬렉션 프레임워크 - Queue
`Queue`와 `Deque` 의 대표적인 구현체는 `ArrayDeque` , `LinkedList` 가 있다.

![큐](https://github.com/user-attachments/assets/1ed4bc30-d22a-4036-ab62-89e33418ccf0)


```java
Queue<Integer> queue = new ArrayDeque<>();
queue.offer(1); 
queue.offer(2);

System.out.println("queue.peek() = " + queue.peek());  // queue.peek() = 1

System.out.println("poll = " + queue.poll()); // poll = 1
System.out.println("poll = " + queue.poll()); // poll = 2
```

- `offer(value)`: 큐에 데이터 넣음
- `peek()`: 다음 꺼낼 데이터 확인
- `poll()`: 큐에서 데이터 꺼내기


### 6. Deque 자료 구조
Deque 는 "Double Ended Queue"의 약자로, 양쪽 끝에서 요소를 추가하거나 제거할 수 있다.

![deque](https://github.com/user-attachments/assets/f8fb45d9-2f1f-4fa1-84c6-79bc2ffdd088)

- `offerFirst()` : 앞에 추가
- `offerLast()` : 뒤에 추가 
- `pollFirst()` : 앞에서 꺼냄
- `pollLast()` : 뒤에서 꺼냄

#### ArrayDeque 구현체 
```java
Deque<Integer> deque = new ArrayDeque<>();

deque.offerFirst(1);  // [1]
deque.offerFirst(2);  // [2, 1] 
deque.offerLast(3);  // [2, 1, 3]
deque.offerLast(4);  // [2, 1, 3, 4]

System.out.println("deque.peekFirst() = " + deque.peekFirst()); // deque.peekFirst() = 2
System.out.println("deque.peekLast() = " + deque.peekLast()); // deque.peekLast() = 4

System.out.println("pollFirst = " + deque.pollFirst()); // pollFirst = 2
System.out.println("pollLast = " + deque.pollLast());
//  pollLast = 4
```
> ArrayDeque는 배열 기반 원형 큐로 LinkedList보다 메모리 접근 효율이 높아 실제 사용 시 더 나은 성능을 보이는 경우가 많다.


### 7. Deque 와 Stack, Queue
`Deque` 는 양쪽으로 데이터를 입력하고 출력할 수 있으므로, 스택과 큐의 역할을 모두 수행할 수 있다.

![Image](https://github.com/user-attachments/assets/60b6b871-c249-48e2-abcc-712bed8631a1)

#### Deque - Stack
`Deque` 는 `Stack` 을 위한 메서드 이름을 제공한다.  
자바의 `Stack` 클래스는 하위 호환을 위해서 남겨져 있는 것이므로 `Stack` 자료 구조가 필요하면 `Deque` 에 `ArrayDeque` 구현체를 사용하자.

#### Deque - Queue
`Deque` 는 `Queue` 을 위한 메서드 이름을 제공한다.  
`Deque` 인터페이스는 `Queue` 인터페이 스의 자식이기 때문에, 단순히 `Queue` 의 기능만 필요하면 `Queue` 인터페이스를 사용하고, 더 많은 기능이 필요하다면 `Deque` 인터페이스를 사용하면 된다.

### 메모
- text.split(" ") : " " 마다 자른 텍스트를 배열로 생성
- map.getOrDefault(K key, V defaultValue) :  지정된 키에 연결된 값을 반환한다. 키가 없는 경우 defaultValue 로 지정한 값을 대신 반환한다 .
- Integer.valueOf(String s) : 문자열을 정수로 변환
- Map.of(K key, V value) : map 생성할때  
- Arrays.toString(배열) : 배열 데이터 나열 