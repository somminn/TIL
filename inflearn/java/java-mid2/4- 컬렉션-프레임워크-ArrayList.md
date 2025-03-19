## 섹션 4. 컬렉션 프레임워크 - ArrayList

### 1. 배열의 특징1 - 배열과 인덱스
`배열과 같이 여러 데이터(자료)를 구조화해서 다루는 것을 자료 구조라 한다.`

#### 배열의 특징
- 배열에서 인덱스를 사용하면 입력, 변경, 조회 모두 한 번의 연산으로 처리할 수 있다.

![배역 메모리 그림](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-17%20%EC%98%A4%ED%9B%84%209.32.19.png?raw=true)
>공식: `배열의 시작 참조 +(자료의 크기 * 인덱스 위치)`  
arr[0]: x100 + (4byte * 0): x100  
arr[1]: x100 + (4byte * 1): x104  
arr[2]: x100 + (4byte * 2): x108

#### 배열의 검색 
`배열에 들어있는 데이터를 찾는 것을 검색이라 한다.`

배열에 들어있는 데이터를 검색할 때는 인덱스를 사용해서 한번에 찾을 수 없으므로 배열에 들어있는 데이터를 하나하나 비교해야 한다.


### 2. 빅오(O) 표기법
`빅오(Big O) 표기법은 데이터 양 증가에 따른 알고리즘 성능 변화를 분석하는 수학적 표현이다.`  
- 빅오 표기법은 별도의 이야기가 없으면 보통 최악의 상황을 가정해서 표기한다.
- 데이터가 매우 많이 들어오면 추세를 보는데 상수는 의미 없기 떄문에 빅오 표기법에서는 상수를 제거한다.

![빅오 표기법 그래프](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-17%20%EC%98%A4%ED%9B%84%209.47.32.png?raw=true)

|   빅오 표기법   |    시간    |               증가 형태               |             예시             |     
|:----------:|:--------:|:---------------------------------:|:--------------------------:|
|    O(1)    |  싱수 시간   | 입력 데이터의 크기에 관계없이 알고리즘의 실행 시간은 일정함 |     배열에서 인덱스를 사용하는 경우      |
|    O(n)    |  선형 시간   |     알고리즘 실행시간이 입력 데이터 크기에 비례      | 배열의 검색, 배열의 모든 요소를 순회하는 경우 |
|   O(n^2)   |  제곱 시간   |   알고리즘 실행 시간이 입력 데이터 크기의 제곱에 비례   |       이중 루프를 사용하는 경우       |
|  O(log n)  |  로그 시간   |    알고리즘의  실행시간이 데이터 크기의 로그에 비례    |           이진 탐색            |
| O(n log n) | 선형 로그 시간 |                                   |       효율적인 정렬 알고리즘들        | 


#### 배열 정리
- 배열의 인덱스 사용 : O(1)
- 배열의 순차 검색 : O(n) (마지막 연산에서 찾는다는 최악의 경우)

### 3. 배열의 특징2 - 데이터 추가
`데이터 추가란, 기존 데이터를 유지하면서 새로운 데이터를 입력하는 것을 뜻한다.`  
데이터를 추가하려면 공간을 확보하기 위해 기존 데이터를 오른쪽으로 한 칸씩 밀어야 한다.

#### 배열의 첫번째 위치에 추가
1. 배열의 첫번째 위치 찾기 (인덱스 사용) : O(1)
2. 모든 데이터를 배열의 크기만큼 한 칸씩 이동 : O(n)
3. `성능 : O(1 + n) -> O(n)`

#### 배열의 중간 위치에 추가
1. 배열의 위치 찾기 (인덱스 사용) : O(1)
2. 인덱스의 오른쪽에 있는 데이터를 모두 한 칸씩 이동 : O(n/2)
3. `성능 : O(1 + n/2) -> O(n)`

#### 배열의 마지막 위치에 추가
1. 배열의 마지막 위치 찾기 (인덱스 사용) : O(1)
2. `성능 : O(1)`

#### 배열의 한계
배열의 단점은 배열의 크기를 배열을 생성하는 시점에 미리 정해야 한다는 점이다.


### 4. 직접 구현하는 배열 List1 - 시작
`리스트는 배열보다 유연한 자료 구조로, 크기가 정적으로 고정된 배열과 달리 배열의 크기가 동적으로 변할 수 있다.`

#### capacity vs size
- capacity : 배열의 크기 (배열.length)
- size : 실제 데이터가 입력된 크기 (리스트의 크기) 

#### 데이터 추가
![데이터 추가](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-18%20%EC%98%A4%ED%9B%84%206.01.21.png?raw=true)

#### 데이터 변경
인덱스를 사용해서 데이터를 변경한다. 해당 인덱스의 위치를 찾아서 변경한다.

![데이터 변경](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-18%20%EC%98%A4%ED%9B%84%206.02.02.png?raw=true)

#### 범위 초과
size 가 배열의 크기인 capacity 에 도달하면 더는 데이터를 추가할 수 없어 예외가 발생한다.

![범위 초과](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-18%20%EC%98%A4%ED%9B%84%206.02.48.png?raw=true)


### 5. 직접 구현하는 배열 List2 - 동적 배열

size 가 capacity 에 도달했다면 새로운 길이로 배열을 생성하고, 기존 배열의 값을 새로운 배열에 복사하면 된다.
```java
public void add(Object e) {
        if (size == elementData.length) {
            grow();
        }
        elementData[size] = e;
        size++;
    }
    
public void grow() {
        int oldCapacity = elementData.length;
        int newCapacity = oldCapacity * 2;
        // 참조값 변경 x100 -> x200
        elementData = Arrays.copyOf(elementData, newCapacity);
    }
```
- `Arrays.copyOf (기존 배열, 새로운 길이)` : 새로운 길이로 배열을 생성하고, 기존 배열의 값을 새로운 배열에 복사
- `elementData = Arrays.copyOf(elementData, newCapacity)` : elementData 에 새로운 배열의 참조값 부여

![배열 크기 초과1](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-18%20%EC%98%A4%ED%9B%84%207.46.20.png?raw=true)
![배열 크기 초과2](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-18%20%EC%98%A4%ED%9B%84%207.46.32.png?raw=true)



### 6. 직접 구현하는 배열 List3 - 기능 추가

#### 앞 중간에 데이터 추가
![데이터 추가](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-18%20%EC%98%A4%ED%9B%84%208.57.53.png?raw=true)
`add(Object e)` : 마지막 위치에 추가를 한다면 기존 데이터를 이동할 필요가 없다. -> O(1)  
`add(int index, Object e)` : 추가할 위치를 확보하기 위해 입력한 위치를 기준으로 데이터를 오른쪽으로 한 칸씩 이동해야 한다. -> O(n)

```java
public void add(int index, Object e) {
        if (size == elementData.length) {
            grow();
        }
        // 데이터 이동
        shiftRightFrom(index);
        elementData[index] = e;
        size++;
    }

// 요소의 마지막부터 index 까지 오른쪽으로 밀기
private void shiftRightFrom(int index) {
        for (int i = size; i > index ; i--) {
            elementData[i] = elementData[i - 1];
        }
    }
```


#### 앞 중간에 데이터 삭제
![데이터 삭제](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-03-18%20%EC%98%A4%ED%9B%84%208.58.13.png?raw=true)
`remove(int 마지막 index)` : 마지막 위치라면 기존 데이터를 이동할 필요가 없다. -> O(1)  
`remove(int 앞 index)` : 삭제할 데이터가 마지막 위치가 아니라면 삭제할 데이터의 위치를 기준으로 데이터를 한 칸씩 왼쪽으로 이동해야 한다. -> O(n)
```java
public Object remove(int index) {
    Object oldValue = get(index);
    shiftLeftFrom(index);

    size--;
    elementData[size] = null;
    return oldValue;
}

// 요소의 index 부터 마지막까지 왼쪽으로 밀기
private void shiftLeftFrom(int index) {
    for (int i = index; i < size - 1 ; i++) {
        elementData[i] = elementData[i + 1];
    }
}
```
- 데이터를 삭제하면 리스트의 크기인 size 가 하나 줄어든다.

#### 배열 리스트의 빅오
- 데이터 추가
  - 마지막에 추가: O(1)
  - 앞, 중간에 추가: O(n)
- 데이터 삭제
  - 마지막에 삭제: O(1)
  - 앞, 중간에 삭제: O(n)
- 인덱스 조회: O(1)
- 데이터 검색: O(n)



### 7. 직접 구현하는 배열 List4 - 제네릭1
타입 안전성을 확보하고 다운 캐스팅 없이 원하는 타입을 반환할 수 있게 제네릭을 사용해서 Object 를 지웠다.  
`public class MyArrayListV4<E>`  
`public void add(E e)`  
`public E get(int index)`  


### 8. 직접 구현하는 배열 List5 - 제네릭2

#### Object 배열을 사용한 이유
`new Object[DEFAULT_CAPACITY]`  
생성자에는 제네릭의 타입 매개변수를 사용할 수 없기 때문에 대안으로 Object 배열을 사용한다. 
따라서 고정된 타입으로 Object 배열에 데이터를 보관하고, 또 데이터를 꺼낼 때도 같은 고정된 타입으로 안전하게 다운 캐스팅 할 수 있게 설정한다.

- 데이터 추가 : `public void add(E e)`
- 데이터 반환
```java
public E get(int index) {
    return (E) elementData[index];
    }
```
get() 에서 데이터를 꺼낼 때 항상 (String) 으로로 다운 캐스팅 한다. 
저장된 데이터들은 모두 String 타입으로 add() 되었기 떄문에 문제가 발생하지 않는다.

#### 배열 리스트의 단점
1. 정확한 크기를 미리 알지 못하면 메모리가 낭비된다.
2. 순서대로 마지막에 데이터를 추가하거나 삭제할 때는 성능이 좋지만 데이터를 중간에 추가하거나 삭제할 때 비효율적이다.