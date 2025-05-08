# 스프링 MVC 웹 페이지

### 부트스트랩
부트스트랩(Bootstrap)은 웹사이트를 쉽게 만들 수 있게 도와주는 HTML, CSS, JS 프레임워크이다.
하나의 CSS로 휴대폰, 태블릿, 데스크탑까지 다양한 기기에서 작동한다.
다양한 기능을 제공하여 사용자가 쉽게 웹사이 트를 제작, 유지, 보수할 수 있도록 도와준다.

## 타임리프
- HTML을 기반으로 동적인 웹 페이지를 생성할 수 있게 도와주는 Java 템플릿 엔진
- 타임리프는 순수 HTML 파일을 웹 브라우저에서 열어도 내용을 확인할 수 있고, 서버를 통해 뷰 템플릿을 거치면 동적으로 변경된 결과를 확인할 수 있다.
- 순수 HTML을 그대로 유지하면서 뷰 템플릿도 사용할 수 있는 타임리프의 특징을 네츄럴 템플릿(natural templates)이라 한다.


### 타임리프 사용 선언
`<html xmlns:th="http://www.thymeleaf.org">`

### 속성 변경 - th:href 
`th:href="@{/css/bootstrap.min.css}"`
- HTML을 그대로 볼 때는 `href` 속성이 사용되고, 뷰 템플릿을 거치면 `th:href` 의 값이 `href` 로 대체되면서 동적으로 변경할 수 있다.

### 타임리프 핵심
- 핵심은 `th:xxx` 가 붙은 부분은 서버사이드에서 렌더링 되고, 기존 것을 대체한다. 
- `th:xxx` 이 없으면 기존 html 의 `xxx` 속성이 그대로 사용된다.
- HTML을 파일 보기를 유지하면서 템플릿 기능도 할 수 있다.

### URL 링크 표현식 - @{...}
`th:href="@{/css/bootstrap.min.css}"`
- `@{...}` : 타임리프는 URL 링크를 사용하는 경우 `@{...}` 를 사용한다. 이것을 URL 링크 표현식이라 한다. 
- URL 링크 표현식을 사용하면 서블릿 컨텍스트를 자동으로 포함한다.
  - 서블릿 컨텍스트(context path)는 애플리케이션의 최상위 URL 경로를 뜻한다.
  - 참고로 @RequestMapping이 붙는 부분은 항상 context path 이후의 부분만을 다룬다.
    - @RequestMapping("/basic/items")
    - context path = /일 경우: http://localhost:8080/basic/items
    - context path = /myapp일 경우: http://localhost:8080/myapp/basic/items

### 속성 변경 - th:onclick
```java
onclick="location.href='addForm.html'"
th:onclick="|location.href='@{/basic/items/add}'|"
```

### 리터럴 대체 - |...|
- 문자와 표현식을 더하기 없이 사용할 수 있다. 
- 전: `th:onclick="'location.href=' + '\'' + @{/basic/items/add} + '\''"`
- 후: `th:onclick="|location.href='@{/basic/items/add}'|"`

### 반복 출력 - th:each
`<tr th:each="item : ${items}">`
- 모델에 포함된 `items` 컬렉션 데이터가 `item` 변수에 하나씩 포함 되고, 반복문 안에서 `item` 변수를 사용할 수 있다.


### 변수 표현식 - ${...}
`<td th:text="${item.price}">10000</td>`
- 모델에 포함된 값이나, 타임리프 변수로 선언한 값을 조회할 수 있다.
- 프로퍼티 접근법을 사용한다. ( `item.getPrice()` )

### 내용 변경 - th:text
`<td th:text="${item.price}">10000</td>`
- 내용의 값을 `th:text` 의 값으로 변경한다.
- 여기서는 10000을 `${item.price}` 의 값으로 변경한다.

### URL 링크 표현식2 - @{...} 
`th:href="@{/basic/items/{itemId}(itemId=${item.id})}"`
- URL 링크 표현식을 사용하면 경로를 템플릿처럼 편리하게 사용할 수 있다.
  - 템플릿: 정적 HTML과 달리, 서버에서 데이터를 주입해 완성된 HTML
- 경로 변수( `{itemId}` ) 뿐만 아니라 쿼리 파라미터도 생성한다.

### URL 링크 간단히
`th:href="@{|/basic/items/${item.id}|}"`


## 서비스 제공 흐름
![서비스 제공 흐름](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-24%20%EC%98%A4%ED%9B%84%205.22.40.png?raw=true)
1. 상품 목록
2. 상품 등록 폼
3. 상품 저장
4. 상품 상세
5. 상품 수정 폼
6. 상품 수정


## 1. 상품 목록 
### BasicItemController
```java
@Controller
@RequestMapping("/basic/items")
@RequiredArgsConstructor
public class BasicItemController {
     private final ItemRepository itemRepository;

     /* @RequiredArgsConstructor 사용해서 생략 가능
     @Autowired // 생성자가 딱 한 개만 있으면 스프링이 해당 생성자에 `@Autowired` 로 의존관계를 주입해준다.
     public BasicItemController(ItemRepository itemRepository) {
        this.itemRepository = itemRepository;
     }
     */
     
     @GetMapping
     public String items(Model model) {
         List<Item> items = itemRepository.findAll();
         model.addAttribute("items", items);
         return "basic/items";
}
     // 테스트용 데이터 추가
     @PostConstruct
     public void init() {
         itemRepository.save(new Item("testA", 10000, 10));
         itemRepository.save(new Item("testB", 20000, 20));
     }
}
```
- `@Controller`: 스프링이 자동으로 스프링 빈으로 등록한다.
- `@RequestMapping("/basic/items")`: URL 중복을 제거한다. (클래스 레벨)
- `@RequiredArgsConstructor`: final이 붙은 멤버변수만 사용해서 생성자를 자동으로 만들어준다. -> 생성자가 하나면  `@Autowired` 생략 가능
- `@GetMapping`: 요청 정보 매핑 + GET 메서드
- `@PostConstruct`: 해당 빈의 의존관계가 모두 주입되고 나면 초기화 용도로 호출된다.

### items.html 
```html
<button class="btn btn-primary float-end"
        onclick="location.href='addForm.html'"
        th:onclick="|location.href='@{/basic/items/add}'|" type="button">상품 등록</button>
//...
<tr th:each="item : ${items}">
  <td><a href="item.html" th:href="@{/basic/items/{itemId} (itemId=${item.id})}" th:text="${item.id}">회원id</a></td>
  <td><a href="item.html" th:href="@{|/basic/items/${item.id}|}" th:text="${item.itemName}">상품명</a></td>
  <td th:text="${item.price}">10000</td>
  <td th:text="${item.quantity}">10</td>
</tr>
```

## 2. 상품 상세
### BasicItemController에 추가
```java
@GetMapping("/{itemId}")
public String item(@PathVariable Long itemId, Model model) {
     Item item = itemRepository.findById(itemId);
     model.addAttribute("item", item);
     return "basic/item";
}
```
- `@PathVariable`: URL 경로의 일부를 변수처럼 받아와서 메서드의 파라미터로 전달

### item.html
```html
<div>
  <label for="itemId">상품 ID</label>
  <input type="text" id="itemId" name="itemId" class="form-control" value="1" th:value="${item.id}" readonly>
</div>
<div>
  <label for="itemName">상품명</label>
  <input type="text" id="itemName" name="itemName" class="form-control" value="상품A" th:value="${item.itemName}" readonly> </div>
<div>
  <label for="price">가격</label>
  <input type="text" id="price" name="price" class="form-control" value="10000" th:value="${item.price}" readonly>
</div>
<div>
  <label for="quantity">수량</label>
  <input type="text" id="quantity" name="quantity" class="form-control" value="10" th:value="${item.quantity}" readonly>
</div>
// ...
<button class="w-100 btn btn-primary btn-lg"
        onclick="location.href='editForm.html'"
        th:onclick="|location.href='@{/basic/items/{itemId}/edit(itemId=${item.id})}'|" type="button">상품 수정</button>
```

#### 속성 변경 - th:value
`th:value="${item.id}"`
- 모델에 있는 item 정보를 획득하고 프로퍼티 접근법으로 출력한다. ( `item.getId()` ) 
- `value` 속성을 `th:value` 속성으로 변경한다.


## 3. 상품 등록 폼
### BasicItemController에 추가
```java
@GetMapping("/add")
public String addForm() {
   return "basic/addForm";
}
```

### addForm.html
```html
<form action="item.html" th:action method="post">
// ...
  <button class="w-100 btn btn-secondary btn-lg"
  onclick="location.href='items.html'"
  th:onclick="|location.href='@{/basic/items}'|"
  type="button">취소</button>
```
#### 속성 변경 - th:action
- HTML form에서 `action` 에 값이 없으면 현재 URL에 데이터를 전송한다.
- 상품 등록 폼의 URL과 실제 상품 등록을 처리하는 URL을 똑같이 맞추고 HTTP 메서드로 두 기능을 구분한다.
    - 상품 등록 폼: GET `/basic/items/add`
    - 상품 등록 처리: POST `/basic/items/add`



## 4. 상품 등록 처리 - @ModelAttribute
- POST - HTML Form 방식 사용
- `content-type: application/x-www-form-urlencoded`
- 메시지 바디에 쿼리 파리미터 형식으로 전달 `itemName=itemA&price=10000&quantity=10`
- @RequestParam, @ModelAttribute 사용 가능

### BasicItemController에 추가
```java
@PostMapping("/add")
public String addItemV3(@ModelAttribute Item item) {
     itemRepository.save(item);
     return "basic/item";
}
```
#### @ModelAttribute 기능
1. 요청 파라미터 처리 (객체 생성 + setter)
- `@ModelAttribute` 는 `Item` 객체를 생성하고, 요청 파라미터의 값을 프로퍼티 접근법(setXxx)으로 입력해준다.
2. Model 추가
- 모델(Model)에 `@ModelAttribute` 로 지정한 객체를 자동으로 넣어준다.
    - 모델 명 생략할 경우: 클래스명(Item) -> 소문자로 -> item
    - 내가 만든 클래스의 객체일 경우에는 @ModelAttribute 생략 가능 -> 비추

    
## 5. 상품 수정 폼
### BasicItemController에 추가
```java
@GetMapping("/{itemId}/edit")
public String editForm(@PathVariable Long itemId, Model model) {
     Item item = itemRepository.findById(itemId);
     model.addAttribute("item", item);
     return "basic/editForm";
}
```
- `@PathVariable`: URL 경로의 일부를 변수처럼 받아와서 메서드의 파라미터로 전달

### editForm.html
```html
<form action="item.html" th:action method="post">
// ...
  <button class="w-100 btn btn-secondary btn-lg"
          onclick="location.href='item.html'"
          th:onclick="|location.href='@{/basic/items/{itemId}(itemId=${item.id})}'|" 
          type="button">취소</button>
```

## 6. 상품 수정 처리
```java
@PostMapping("/{itemId}/edit")
public String edit(@PathVariable Long itemId, @ModelAttribute Item item) {
     itemRepository.update(itemId, item);
     return "redirect:/basic/items/{itemId}";
}
```

#### 리다이렉트
- 상품 수정은 마지막에 뷰 템플릿을 호출하는 대신에 상품 상세 화면으로 이동하도록 리다이렉트를 호출한다. 
- `return "redirect:/..."`: 브라우저에게 요청을 새로 보내라고 지시하는 것 (HTTP 302 리다이렉트 응답)
- `return "basic/item/{itemId}"`: 서버에게 해당 템플릿을 찾으라고 지시하는 것 -> 해당 뷰는 존재하지 않아 에러


# PRG Post/Redirect/Get
- 웹 브라우저의 새로 고침은 마지막에 서버에 전송한 데이터를 다시 전송한다.
- 상품 등록 폼에서 데이터를 입력하고 저장을 선택한 상태에서 새로고침을 하면 POST 요청을 계속 하는 것

![리다이렉트](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-24%20%EC%98%A4%ED%9B%84%206.54.42.png?raw=true)
- 상품 등록 처리 이후에 뷰 템플릿이 아니라 상품 상세 화면으로 리다이렉트 하도록 했다. 
- 이런 문제 해결 방식을 `PRG Post/Redirect/Get` 라 한다.

### BasicItemController에 추가
```java
@PostMapping("/add")
public String addItemV5(Item item) {
     itemRepository.save(item);
     return "redirect:/basic/items/" + item.getId();
}
```

## RedirectAttributes
저장이 잘 되었으면 상품 상세 화면에 "저장되었습니다"라는 메시지를 보여달라는 요구사항이 왔다.
### BasicItemController에 추가
```java
@PostMapping("/add")
public String addItemV6(Item item, RedirectAttributes redirectAttributes) {
     Item savedItem = itemRepository.save(item);
     redirectAttributes.addAttribute("itemId", savedItem.getId());
     redirectAttributes.addAttribute("status", true);
     return "redirect:/basic/items/{itemId}";
}
```
리다이렉트 할 때 간단히 `status=true` 를 추가해보자. 그리고 뷰 템플릿에서 이 값이 있으면, 저장되었습니다. 라는 메시지를 출력해보자.

### item.html에 추가
```html
<h2 th:if="${param.status}" th:text="'저장 완료!'"></h2>
```
- `th:if` : 해당 조건이 참이면 실행
- `${param.status}` : 타임리프에서 쿼리 파라미터를 편리하게 조회하는 기능