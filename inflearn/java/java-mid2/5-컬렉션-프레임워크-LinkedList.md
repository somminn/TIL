## 섹션 5. 컬렉션 프레임워크 - LinkedList

### 1. 노드와 연결1
#### 배열 리스트의 단점
1. 정확한 크기를 미리 알지 못하면 메모리가 낭비된다.
2. 데이터를 중간에 추가하거나 삭제할 때 비효율적이다.

#### 노드와 연결
`필요한 만큼만 메모리를 할당하고, 데이터의 추가·삭제가 효율적인 구조가 노드와 노드를 연결하는 방식이다.`

- 노드 클래스
```java
public class Node {
      Object item;
        Node next; 
}
```
- 노드 생성 : Node next 필드에 다음 노드의 참조값을 넣는다.
```java
Node first = new Node("A");
first.next = new Node("B");
first.next.next = new Node("C");
```

![노드연결](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-19%20%EC%98%A4%EC%A0%84%209.33.24.png?raw=true)

#### 모든 노드 탐색하기
```java
Node x = first;
  while (x != null) {
      System.out.println(x.item);
      x = x.next; 
}
```
![모든 노드 탐색하기](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-19%20%EC%98%A4%EC%A0%84%209.37.25.png?raw=true)

### 2. 노드와 연결2
#### toString() - 직접 구현


### 3. 노드와 연결3
#### 모든 노드 탐색하기
```java
private static void printAll(Node node) {
    Node x = node;
    while (x != null) {
        System.out.println(x.item);
        x = x.next;
    }
}
```

#### 마지막 노드 조회하기
```java
private static Node getLastNode(Node node) {
    Node x = node;
    while (x.next  != null) {
        x = x.next;
    }
    return x;
}
```

#### 특정 index 의 노드 조회하기
```java
private static Node getNode(Node node, int index) {
    Node x = node;
    for (int i = 0; i < index; i++) {
        x = x.next;
    }
    return x;
}
```

#### 노드에 데이터 추가하기
```java
private static void add(Node node, String param) {
    Node lastNode = getLastNode(node);
    lastNode.next = new Node(param);
}
```

### 4. 직접 구현하는 연결 리스트1 - 시작
`노드와 연결 구조를 통해서 만든 자료 구조를 연결 리스트(LinkedList) 라 한다.`  
연결 리스트는 배열 리스트의 단점인, 메모리 낭비, 중간 위치의 데이터 추가에 대한 성능 문제를 어느정도 극복할 수 있다.


#### 데이터 추가 : void add(Object e)
```java
public void add(Object e) {
    Node newNode = new Node(e);
    if (first == null) {
        first = newNode;
    } else {
        Node lastNode = getLastNode();
        lastNode.next = newNode;
    }
    size++;
}
```
- 새로운 노드를 만들고, 마지막 노드를 찾아서 새로운 노드를 마지막에 연결한다.
- O(n) : 마지막 노드를 찾는데 O(n)이 소요된다.

#### 데이터 변경 : Object set(int index, Object element)
```java
public Object set(int index, Object element) {
    Node x = getNode(index);
    Object oldValue = x.item;
    x.item = element;
    return oldValue;
}
```
- 특정 위치에 있는 데이터를 찾아서 변경한다. 그리고 기존 값을 반환한다.
- O(n) : 특정 위치의 노드를 찾는데 O(n)이 걸린다.

#### 데이터 반환 : Object get(int index)
```java
public Object get(int index) {
    Node node = getNode(index);
    return node.item;
}
```
- getNode(index) 를 통해 특정 위치에 있는 노드를 찾고, 해당 노드에 있는 값을 반환한다.
- O(n) : 배열리스트는 인덱스로 바로 접근 가능하여 O(1)의 조회 성능을 보장하지만, 연결 리스트는 각 노드가 다음 노드를 참조하는 방식이므로 특정 인덱스의 노드를 찾기 위해 O(n)의 시간이 소요된다.

#### 데이터 조회 : int indexOf(Object o)
```java
public int indexOf(Object o) {
    int index = 0;
    for (Node x = first; x != null; x = x.next) {
        if (o.equals(x.item)) {
            return index;
        }
        index++;
    }
    return -1;
}
```
- 데이터를 검색하고, 검색된 위치를 반환한다.
- O(n) : 모든 노드를 순회하면서 equals() 를 사용해서 같은 데이터가 있는지 찾는다.

### 5. 직접 구현하는 연결 리스트2 - 추가와 삭제1

#### void add(int index, Object e)
```java
public void add(int index, Object e) {
    Node newNode = new Node(e);
    if (index == 0) {
        newNode.next = first;
        first = newNode;
    } else {
        Node prev = getNode(index - 1);
        newNode.next = prev.next;
        prev.next = newNode;
        }
    size++;
}
```
1. 첫 번째 위치에 데이터 추가
   - 신규 노드 생성 
   - 신규 노드와 다음 노드(first) 연결
   - first 에 신규 노드 연결
2. 중간 위치에 데이터 추가
   - 새로운 노드를 생성하고, 노드가 입력될 위치의 직전 노드(prev)를 찾기
   - 직전 노드(prev)의 next 값으로 신규 노드와 다음 노드 연결 
   - 직전 노드(prev)에 신규 노드 연결

#### Object remove(int index)
1. 첫 번째 위치의 데이터 삭제
   - 삭제 대상 선택
   - first 에 삭제 대상의 다음 노드 연결
   - 삭제 대상의 데이터 초기화
2. 중간 위치의 데이터 삭제
   - 삭제 대상과 삭제 대상의 직전 노드(prev) 찾기
   - 삭제 노드의 next 값으로 직전 노드(prev)와 다음 노드 연결
   - 삭제 노드의 데이터 초기화


### 6. 직접 구현하는 연결 리스트3 - 추가와 삭제2











### 메모
스프링 빌더 : 루프에서 문자열을 더할때 쓰면 좋음