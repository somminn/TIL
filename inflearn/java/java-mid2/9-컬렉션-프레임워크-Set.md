## 섹션 9. 컬렉션 프레임워크 - Set

### 1. 자바가 제공하는 Set1 - HashSet, LinkedHashSet

#### Set 인터페이스
- 중복을 허용하지 않는다.
- 순서를 보장하지 않는다.
- 특정 요소가 집합에 있는지 여부를 확인하는 데 최적화되어 있다.

![Set](https://github.com/user-attachments/assets/fa440cbc-74b7-4ae6-a7b5-c81d8fd077fc)

#### Set 의 주요 구현체
- HashSet
- LinkedHashSet
- TreeSet

#### HashSet
![HashSet](https://github.com/user-attachments/assets/37ea9d35-61f8-4f29-b180-ac75dea65d5c)
- 구현: 해시 자료 구조를 사용해서 요소를 저장한다. (hashCode, hashIndex)
- 순서: 요소들은 특정한 순서 없이 저장된다.
- 시간 복잡도: 주요 연산(추가, 삭제, 검색)은 평균적으로 O(1) 시간 복잡도를 가진다. 
- 용도: 데이터의 유일성만 중요하고, 순서가 중요하지 않은 경우에 적합하다.

#### LinkedHashSet
![LinkedHashSet](https://github.com/user-attachments/assets/05e03be2-c2e0-4943-84df-629e28fcd4a6)
- 구현: HashSet 에 연결 리스트를 추가해서 요소들의 순서를 유지한다.
- 순서: 요소들은 추가된 순서대로 유지된다. 즉, 순서대로 조회 시 요소들이 추가된 순서대로 반환된다.
- 시간 복잡도: 주요 연산에 대해 평균 O(1) 시간 복잡도를 가진다.
- 용도: 데이터의 유일성과 함께 삽입 순서를 유지해야 할 때 적합하다.
- 참고: 연결 링크를 유지해야 하기 때문에 HashSet 보다는 조금 더 무겁다.


### 2. 자바가 제공하는 Set2 - TreeSet
#### TreeSet
- 구현: TreeSet 은 이진 탐색 트리를 개선한 레드-블랙 트리를 내부에서 사용한다.
- 순서: 요소들은 정렬된 순서로 저장된다. 순서의 기준은 비교자로 변경할 수 있다.
- 시간 복잡도: 주요 연산들은 O(log n) 의 시간 복잡도를 가진다.
- 용도: 데이터들을 정렬된 순서로 유지하면서 집합의 특성을 유지해야 할 때 사용한다. 참고로 입력된 순서가 아니라 데이터 값의 순서이다.

#### 트리 구조
- 트리는 부모 노드와 자식 노드로 구성된다.
- 가장 높은 조상을 루트(root)라 한다.

#### 이진 탐색 트리
![트리 구조](https://github.com/user-attachments/assets/dc2f3eef-0947-4abf-8564-4d964c407b8e)
- 이진 트리 : 자식이 2개까지 올 수 있는 트리
- 이진 탐색 트리 : 노드의 왼쪽 자손은 더 작은 값을 가지고, 오른쪽 자손은 더 큰 값을 가지는 이진 트리

#### 이진 탐색 트리 - 입력
작은 값은 왼쪽에 큰 값은 오른쪽에 저장하면 된다.  
이진 탐색 트리의 핵심은 데이터를 입력하는 시점에 정렬해서 보관한다는 점이다.


#### 이진 탐색 트리 - 검색
![이진 탐색 트리 - 검색](https://github.com/user-attachments/assets/07c0caec-e6e6-4ab2-828c-52d83a375bb8)

숫자 35를 검색할 경우, 총 4번의 계산으로 필요한 결과를 얻을 수 있다. 이것은 O(n) 인 리스트의 검색보다는 빠르고, O(1)인 해시의 검색 보다는 느리다.  

이진 탐색 트리 계산의 핵심은 한번에 절반을 날린 다는 점이다.

#### 이진 탐색 트리의 빅오 - O(log n)
![빅오 표기법 그래프](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-17%20%EC%98%A4%ED%9B%84%209.47.32.png?raw=true)
>2개의 데이터 : 2로 1번 나누기, log2(2)=1  
4개의 데이터 : 2로 2번 나누기, log2(4)=2   
8개의 데이터 : 2로 3번 나누기, log2(8)=3

쉽게 이야기해서 2로 몇번 나누어서 1에 도달할 수 있는지 계산하면 된다.

#### 이진 탐색 트리 - 순회
데이터를 차례로 순회하려면 중위 순회라는 방법을 사용하면 된다.  
자신의 왼쪽의 모든 노드를 처리하고, 자신의 노드를 처리하고, 자신의 오른쪽 모든 노드를 처리하는 방식이다.

### 3. 자바가 제공하는 Set3 - 예제
```java
public class JavaSetMain {
    public static void main(String[] args) {
        run(new HashSet<>());
        run(new LinkedHashSet<>());
        run(new TreeSet<>());
    }
    private static void run(Set<String> set) {
        System.out.println("set = " + set.getClass());
        set.add("C");
        set.add("B");
        set.add("A");
        set.add("1");
        set.add("2");

        Iterator<String> iterator = set.iterator();
        while (iterator.hasNext()) { // iterator.hasNext() : 다음 데이터가 있는지 확인
            System.out.print(iterator.next() + " "); // iterator.next() : 다음 데이터를 반환한다.
        }
        System.out.println();
    }
}
```
```java
set = class java.util.HashSet
A 1 B 2 C  
set = class java.util.LinkedHashSet
C B A 1 2 
set = class java.util.TreeSet
1 2 A B C 
```
- `HashSet` : 입력한 순서를 보장하지 않는다.
- `LinkedHashSet` : 입력한 순서를 정확히 보장한다.
- `TreeSet` : 데이터 값을 기준으로 정렬한다.

실무에서는 Set 이 필요한 경우 `HashSet` 을 가장 많이 사용한다.   
그리고 입력 순서 유지, 값 정렬의 필요에 따라서 `LinkedHashSet` , `TreeSet` 을 선택하면 된다.

### 4. 자바가 제공하는 Set4 - 최적화

#### 재해싱(rehashing)
자바의 `HashSet` 은  데이터 양이 75% 이상이면 배열의 크기를 2배로 증가하고, 모든 데이터의 해시 인덱스를 커진 배열에 맞추어 다시 계산한다.


### 5. 문제와 풀이1
- 배열을 루프로 돌려 Set에 입력
```java
Integer[] inputArr = {30, 20, 20, 10, 10};
Set<Integer> set = new HashSet<>();
for (Integer s : inputArr) {
    set.add(s);
}
```
- ref) 배열을 List로 변환해 Set에 입력 (List는 Collection의 자식)
```java
Integer[] inputArr = {30, 20, 20, 10, 10};
Set<Integer> set = new HashSet<>(List.of(inputArr));
```

- ref) 배열 리스트 생성 후 Set에 입력
```java
Set<Integer> set = new TreeSet<>(List.of(30, 20, 20, 10, 10));
```

### 6. 문제와 풀이2
- 합집합
```java
set1.addAll(set2);  // set1에 set2 합치기
```

- 교집합
```java
set1.retainAll(set2); 
```

- 차집합
```java
set1.removeAll(set2); // set1에서 set2와의 중복값 삭제
```



