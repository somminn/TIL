# 스프링 MVC - 구조 이해 


## SpringMVC 구조
![SpringMVC 구조](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-22%20%EC%98%A4%EC%A0%84%209.27.51.png?raw=true)

### 동작 순서
1. **핸들러 조회**: 핸들러 매핑을 통해 요청 URL에 매핑된 핸들러(컨트롤러)를 조회한다.
2. **핸들러 어댑터 조회**: 핸들러를 실행할 수 있는 핸들러 어댑터를 조회한다.
3. **핸들러 어댑터 실행**: 핸들러 어댑터를 실행한다.
4. **핸들러 실행**: 핸들러 어댑터가 실제 핸들러를 실행한다.
5. **ModelAndView 반환**: 핸들러 어댑터는 핸들러가 반환하는 정보를 ModelAndView로 변환해서 반환한다.
6. **viewResolver 호출**: 뷰 리졸버를 찾고 실행한다. 
   - JSP의 경우: `InternalResourceViewResolver` 가 자동 등록되고, 사용된다.
7. **View 반환**: 뷰 리졸버는 뷰의 논리 이름을 물리 이름으로 바꾸고, 렌더링 역할을 담당하는 뷰 객체를 반환한다. 
   - JSP의 경우 `InternalResourceView(JstlView)` 를 반환하는데, 내부에 `forward()` 로직이 있다.
8. **뷰 렌더링**: 뷰를 통해서 뷰를 렌더링 한다.


## DispatcherServlet 구조 살펴보기
- 스프링 MVC의 프론트 컨트롤러가 바로 `DispatcherServlet`이다.
- 스프링 부트는 `DispatcherServlet` 을 서블릿으로 자동으로 등록하면서 모든 경로(`urlPatterns="/"`)에 대해서 매핑한다.
- `DispatcherServlet`이 모든 요청을 먼저 받아서 필요한 핸들러(컨트롤러나 정적 리소스 등)로 전달한다.

### DispatcherServlet.doDispatch()
```java
protected void doDispatch(HttpServletRequest request, HttpServletResponse response) throws Exception {
    HttpServletRequest processedRequest = request;
    HandlerExecutionChain mappedHandler = null;
    ModelAndView mv = null;

    // 1. 핸들러 조회
    mappedHandler = getHandler(processedRequest); 
    if (mappedHandler == null) {
         noHandlerFound(processedRequest, response); 
         return; }

    //2.핸들러 어댑터 조회-핸들러를 처리할 수 있는 어댑터
    HandlerAdapter ha = getHandlerAdapter(mappedHandler.getHandler());

    // 3. 핸들러 어댑터 실행 -> 4. 핸들러 어댑터를 통해 핸들러 실행 -> 5. ModelAndView 반환 
    mv = ha.handle(processedRequest, response, mappedHandler.getHandler());
    
    processDispatchResult(processedRequest, response, mappedHandler, mv, dispatchException);
}

private void processDispatchResult(HttpServletRequest request, HttpServletResponse response, HandlerExecutionChain mappedHandler, ModelAndView mv, Exception exception) throws Exception {
    // 뷰 렌더링 호출
    render(mv, request, response);
}

protected void render(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws Exception {
    View view;
    String viewName = mv.getViewName(); 
    
    // 6. 뷰 리졸버를 통해서 뷰 찾기, // 7. View 반환
    view = resolveViewName(viewName, mv.getModelInternal(), locale, request);

    // 8. 뷰 렌더링
    view.render(mv.getModelInternal(), request, response);
}
```


## 주요 인터페이스 목록
스프링 MVC는 대부분의 기능들을 인터페이스로 제공하기때문에 `DispatcherServlet` 코드의 변경 없이, 원하는 기능을 변경하거나 확장할 수 있다.
- 핸들러 매핑: `org.springframework.web.servlet.HandlerMapping`
- 핸들러 어댑터: `org.springframework.web.servlet.HandlerAdapter` 
- 뷰 리졸버: `org.springframework.web.servlet.ViewResolver`
- 뷰: `org.springframework.web.servlet.View`


## 핸들러 매핑과 핸들러 어댑터
1. 핸들러 매핑으로 핸들러 조회
2. 핸들러 어댑터 조회
3. 핸들러 어댑터 실행

### 스프링 부트가 자동 등록하는 핸들러 매핑과 핸들러 어댑터
#### HandlerMapping
```java
0 = RequestMappingHandlerMapping    : 애노테이션 기반의 컨트롤러인 @RequestMapping에서 사용
1 = BeanNameUrlHandlerMapping       : 스프링 빈의 이름으로 핸들러를 찾는다.
```

#### HandlerAdapter                                                                               
```java
 0 = RequestMappingHandlerAdapter   : 애노테이션 기반의 컨트롤러인 @RequestMapping에서 사용 
 1 = HttpRequestHandlerAdapter      : HttpRequestHandler 처리
 2 = SimpleControllerHandlerAdapter : Controller 인터페이스(애노테이션X, 과거에 사용) 처리
```

실무에서는 99.9% `RequestMappingHandlerMapping`, `RequestMappingHandlerAdapter` 방식의 컨트롤러를 사용한다. → `@RequestMapping`


## 뷰 리졸버
1. 핸들러 어댑터 호출: 핸들러 어댑터를 통해 논리 뷰 이름 획득
2. ViewResolver 호출: 논리 뷰 이름으로 물리 뷰 호출
3. InternalResourceViewResolver: 물리 뷰 반환
4. view.render(): JSP 실행

- 스프링 부트는 `InternalResourceViewResolver` 라는 뷰 리졸버를 자동으로 등록한다.
- `application.properties` 에 등록한 `spring.mvc.view.prefix` , `spring.mvc.view.suffix` 설정 정보를 사용해서 등록한다.

### 스프링 부트가 자동 등록하는 뷰 리졸버
```java
1 = BeanNameViewResolver         : 빈 이름으로 뷰를 찾아서 반환한다. (예: 엑셀 파일 생성 기능 에 사용)
2 = InternalResourceViewResolver : JSP를 처리할 수 있는 뷰를 반환한다.
```





# 스프링 MVC - 시작하기
## @RequestMapping
스프링에서 주로 사용하는 애노테이션 기반의 컨트롤러를 지원하는 핸들러 매핑과 어댑터로 실무에서는 99.9% 이 방식을 사용한다.
- `RequestMappingHandlerMapping` 
- `RequestMappingHandlerAdapter`


```java
@Controller
@RequestMapping("/springmvc/v3/members")
public class SpringMemberControllerV3 {
   private MemberRepository memberRepository = MemberRepository.getInstance();
   
   @GetMapping("/new-form")
   public String newForm() {
      return "new-form";
   }
   
   @PostMapping("/save")
   public String save(
           @RequestParam("username") String username,
           @RequestParam("age") int age,
           Model model) {
      Member member = new Member(username, age);
      memberRepository.save(member);
      model.addAttribute("member", member);
      return "save-result";
   }
   
   @GetMapping
   public String members(Model model) {
      List<Member> members = memberRepository.findAll();
      model.addAttribute("members", members);
      return "members";
   } 
}
```
### @Controller
- 스프링이 자동으로 스프링 빈으로 등록한다. → 매핑 정보로 인식
- 내부에 `@Component` 애노테이션이 있어서 컴포넌트 스캔의 대상이 된다.

### @RestController
- `@RestController`는 반환 값으로 뷰를 찾는 것이 아니라, HTTP 메시지 바디에 바로 입력한다.
- `@Controller` 는 반환 값이 `String` 이면 뷰 이름으로 인식된다. 그래서 뷰를 찾고 뷰가 랜더링된다.

### @RequestMapping
- 클래스 레벨 `@RequestMapping("/springmvc/v3/members")`: URL 중복을 제거한다.
- 메서드 레벨 `@RequestMapping`: 요청 정보를 매핑한다. 해당 URL이 호출되면 이 메서드가 실행되도록 매핑한다.
  - `@GetMapping`: 요청 정보 매핑 + GET 메서드 
  - `@PostMapping`: 요청 정보 매핑 + POST 메서드
  - method 속성으로 HTTP 메서드를 지정하지 않으면 HTTP 메서드와 무관하게 호출된다.


### @RequestParam
- HTTP 요청 파라미터 받는다.

### `Model` 파라미터
- `model.addAttribute`: Model 데이터 추가하는 메서드

### `ViewName` 직접 반환


   

# 스프링 MVC - 기본 기능
# 요청 매핑

### MappingController
```java
@RestController
public class MappingController {
     private Logger log = LoggerFactory.getLogger(getClass());

     @RequestMapping("/hello-basic")
     public String helloBasic() {
         log.info("helloBasic");
         return "ok";
     }
}
```
### 매핑 정보
#### @RestController
- `@Controller` 는 반환 값이 `String` 이면 뷰 이름으로 인식된다. 그래서 뷰를 찾고 뷰가 랜더링된다.
- `@RestController` 는 반환 값으로 뷰를 찾는 것이 아니라, HTTP 메시지 바디에 바로 입력한다. 따라서 실행 결과로 ok 메세지를 받을 수 있다. `@ResponseBody` 와 관련이 있는데, 뒤에서 더 자세히 설명한다. 

#### @RequestMapping("/hello-basic")
- `/hello-basic` URL 호출이 오면 이 메서드가 실행되도록 매핑한다.
- 대부분의 속성을 `배열[]` 로 제공하므로 다중 설정이 가능하다. `{"/hello-basic", "/hello-go"}`


### HTTP 메서드 매핑
```java
@GetMapping(value = "/mapping-get-v2")
public String mappingGetV2() {
    log.info("mapping-get-v2");
    return "ok";
}
```
#### @RequestMapping
- 클래스 레벨 `@RequestMapping("/springmvc/v3/members")`: URL 중복을 제거한다.
- 메서드 레벨 `@RequestMapping`: 요청 정보를 매핑한다. 해당 URL이 호출되면 이 메서드가 실행되도록 매핑한다.
    - `@GetMapping`: 요청 정보 매핑 + GET 메서드
    - `@PostMapping`: 요청 정보 매핑 + POST 메서드
    - method 속성으로 HTTP 메서드를 지정하지 않으면 HTTP 메서드와 무관하게 호출된다.

    
### @PathVariable (경로 변수)
```java
@GetMapping("/mapping/{userId}")
public String mappingPath(@PathVariable("userId") String data) {
     log.info("mappingPath userId={}", data);
     return "ok";
}
```
- `@RequestMapping` 은 URL 경로를 템플릿화 할 수 있는데, `@PathVariable` 을 사용하면 매칭 되는 부분을 편리하게 조회할 수 있다.
- `@PathVariable` 의 이름과 파라미터 이름이 같으면 생략할 수 있다.

### 특정 헤더 조건 매핑
```java
@GetMapping(value = "/mapping-header", headers = "mode=debug")
public String mappingHeader() {
     log.info("mappingHeader");
     return "ok";
}
```
/mapping-header 중 mode 헤더가 debug 상태인 요청만 매핑

### 미디어 타입 조건 매핑 - HTTP 요청 Content-Type, consume
```java
@PostMapping(value = "/mapping-consume", consumes = "application/json")
public String mappingConsumes() {
     log.info("mappingConsumes");
     return "ok";
}
```
- /mapping-consume 중 컨텐츠 타입이 application/json인 요청만 매핑 
- 만약 맞지 않으면 HTTP 415 상태코드(Unsupported Media Type)을 반환한다.

### 미디어 타입 조건 매핑 - HTTP 요청 Accept, produce
```java
@PostMapping(value = "/mapping-produce", produces = "text/html")
public String mappingProduces() {
    log.info("mappingProduces");
    return "ok";
}
```
- /mapping-produce 중 Accept 헤더의 미디어 타입이 text/html인 요청만 매핑
- 만약 맞지 않으면 HTTP 406 상태코드(Not Acceptable)을 반환한다.


## HTTP 요청 - 기본, 헤더 조회
## HTTP 요청 파라미터 - 쿼리 파라미터, HTML Form
request.getParameter()

## HTTP 요청 파라미터 - @RequestParam
스프링이 제공하는 `@RequestParam` 을 사용하면 요청 파라미터를 매우 편리하게 사용할 수 있다.
```java
@ResponseBody
@RequestMapping("/request-param-v2")
public String requestParamV2(
        @RequestParam("username") String memberName,  // request.getParameter("username") 과 같음 
        @RequestParam("age") int memberAge) {
    log.info("username={}, age={}", memberName, memberAge);
    return "ok";
}
```
### @ResponseBody
View 조회를 무시하고, HTTP message body에 직접 해당 내용 입력

### @RequestParam
- 파라미터 이름으로 바인딩
- HTTP 파라미터 이름이 변수 이름과 같으면 @RequestParam(name="xx") 생략 가능
  - `(@RequestParam String username, @RequestParam int age)`
- String, int, Integer 등의 단순 타입이면 @RequestParam도 생략 가능 (비추)
  - `(String username, int age)`

### 파라미터 필수 여부 - requestParamRequired
```java
@ResponseBody
@RequestMapping("/request-param-required")
public String requestParamRequired(
         @RequestParam(required = true) String username,
         @RequestParam(required = false) Integer age) {
     log.info("username={}, age={}", username, age);
     return "ok";
}
```
#### @RequestParam.required
- 파라미터 필수 여부
- 기본값이 파라미터 필수(`true`)이다.
- 파라미터 이름만 있고 값이 없는 경우 → 빈문자로 통과


### 기본 값 적용 - requestParamDefault
```java
@ResponseBody
@RequestMapping("/request-param-default")
public String requestParamDefault(
         @RequestParam(required = true, defaultValue = "guest") String username,
         @RequestParam(required = false, defaultValue = "-1") int age) {
     log.info("username={}, age={}", username, age);
     return "ok";
}
```
### @RequestParam.defaultValue
- 파라미터에 값이 없는 경우 `defaultValue` 를 사용하면 기본 값을 적용할 수 있다.
- 빈 문자의 경우에도 설정한 기본 값이 적용된다.

### 파라미터를 Map으로 조회하기 - requestParamMap
```java
@ResponseBody
@RequestMapping("/request-param-map")
public String requestParamMap(@RequestParam Map<String, Object> paramMap) {
     log.info("username={}, age={}", paramMap.get("username"), paramMap.get("age"));
     return "ok";
}
```
파라미터의 값이 1개가 확실하다면 `Map` 을 사용해도 되지만, 그렇지 않다면 `MultiValueMap` 을 사용하자.




## HTTP 요청 파라미터 - @ModelAttribute
요청 파라미터를 받아서 필요한 객체를 만들고 그 객체에 값을 넣어주는 과정을 자동화해줌

### HelloData
요청 파라미터를 바인딩 받을 객체
```java
@Data
public class HelloData {
        private String username;
        private int age;
}
```
`@Data`: `@Getter`, `@Setter`, `@ToString`, `@EqualsAndHashCode`, `@RequiredArgsConstructor` 를 자동으로 적용해준다.

### @ModelAttribute 적용
```java 
@ResponseBody
@RequestMapping("/model-attribute-v1")
public String modelAttributeV1(@ModelAttribute HelloData helloData) {
     log.info("username={}, age={}", helloData.getUsername(), helloData.getAge());
     return "ok";
}
```
스프링MVC는 `@ModelAttribute` 가 있으면 다음을 실행한다.
1. `HelloData` 객체를 생성한다.
2. 요청 파라미터의 이름으로 `HelloData` 객체의 프로퍼티를 찾는다. 그리고 해당 프로퍼티의 setter를 호출해서 파라미터의 값을 입력(바인딩) 한다.
3. 예) 파라미터 이름이 `username` 이면 `setUsername()` 메서드를 찾아서 호출하면서 값을 입력한다.

- `@ModelAttribute` 는 생략할 수 있다.
  - `(HelloData helloData)`
- `@RequestParam`도 생략할 수 있으니 스프링은 해당 생략시 다음과 같은 규칙을 적용한다.
  - String, int, Integer 같은 단순 타입 = `@RequestParam`
  - 나머지 = `@ModelAttribute` (argument resolver 로 지정해둔 타입 외)

## HTTP 요청 메시지 - 단순 텍스트
요청 파라미터와 다르게, HTTP 메시지 바디를 통해 데이터가 직접 넘어오는 경우는 `@RequestParam` , `@ModelAttribute` 를 사용할 수 없다. 

### Input, Output 스트림, Reader
```java
@PostMapping("/request-body-string-v2")
public void requestBodyStringV2(InputStream inputStream, Writer responseWriter) throws IOException {
     String messageBody = StreamUtils.copyToString(inputStream, StandardCharsets.UTF_8);
     log.info("messageBody={}", messageBody);
     responseWriter.write("ok");
 }
```
스프링 MVC는 다음 파라미터를 지원한다.
- `InputStream(Reader)`: HTTP 요청 메시지 바디의 내용을 직접 조회 
- `OutputStream(Writer)`: HTTP 응답 메시지의 바디에 직접 결과 출력

### HttpEntity
```java
@PostMapping("/request-body-string-v3")
public HttpEntity<String> requestBodyStringV3(HttpEntity<String> httpEntity) {
    String messageBody = httpEntity.getBody();
    log.info("messageBody={}", messageBody);
    return new HttpEntity<>("ok");
}
```
스프링 MVC는 다음 파라미터를 지원한다.
- `HttpEntity`: HTTP header, body 정보를 편리하게 조회
  - 메시지 바디 정보를 직접 조회
  - `RequestEntity`: HttpMethod, url 정보가 추가, 요청에서 사용
  - `ResponseEntity`: HTTP 상태 코드 설정 가능, 응답에서 사용
  - 요청 파라미터를 조회하는 기능과 관계 없음 `@RequestParam` X, `@ModelAttribute` X
- HttpEntity는 응답에도 사용 가능
  - 메시지 바디 정보 직접 반환, 헤더 정보 포함 가능, view 조회X

### @RequestBody
```java
@ResponseBody 
@PostMapping("/request-body-string-v4")
public String requestBodyStringV4(@RequestBody String messageBody) {
     log.info("messageBody={}", messageBody);
     return "ok";
}
```
- `@RequestBody` 를 사용하면 HTTP 메시지 바디 정보를 편리하게 조회할 수 있다. 
- 이렇게 메시지 바디를 직접 조회하는 기능은 요청 파라미터를 조회하는 `@RequestParam` , `@ModelAttribute` 와는 전혀 관계가 없다.
- `@ResponseBody`: 응답 결과를 HTTP 메시지 바디에 직접 담아서 전달할 수 있다.

- 요청 파라미터 vs HTTP 메시지 바디
  - 요청 파라미터를 조회하는 기능: `@RequestParam` , `@ModelAttribute` 
  - HTTP 메시지 바디를 직접 조회하는 기능: `@RequestBody`



## HTTP 요청 메시지 - JSON

### @RequestBody 문자 변환
```java
private ObjectMapper objectMapper = new ObjectMapper();

@ResponseBody
@PostMapping("/request-body-json-v2")
public String requestBodyJsonV2(@RequestBody String messageBody) throws IOException {
     HelloData data = objectMapper.readValue(messageBody, HelloData.class);
     log.info("username={}, age={}", data.getUsername(), data.getAge());
     return "ok";
}
```
- `@RequestBody` 를 사용해서 HTTP 메시지에서 데이터를 꺼내고 messageBody에 저장한다.
- 문자로 된 JSON 데이터인 `messageBody` 를 `objectMapper` 를 통해서 자바 객체로 변환한다.


### @RequestBody 객체 변환
```java
@ResponseBody
@PostMapping("/request-body-json-v3")
public String requestBodyJsonV3(@RequestBody HelloData data) {
    log.info("username={}, age={}", data.getUsername(), data.getAge());
    return "ok";
}
```
- `@RequestBody` 에 직접 만든 객체를 지정할 수 있다.
- `@RequestBody`는 생략 불가능
- `@RequestBody` 요청: `JSON 요청 → HTTP 메시지 컨버터 → 객체` 
- `@ResponseBody` 응답: `객체 → HTTP 메시지 컨버터 → JSON 응답`

### HttpEntity
```java
@ResponseBody
@PostMapping("/request-body-json-v4")
public String requestBodyJsonV4(HttpEntity<HelloData> httpEntity) {
     HelloData data = httpEntity.getBody();
     log.info("username={}, age={}", data.getUsername(), data.getAge());
     return "ok";
}
```




## HTTP 응답 - 정적 리소스, 뷰 템플릿
스프링에서 응답 데이터 만드는 방법
1. 정적 리소스
2. 뷰 템플릿 사용
3. HTTP 메시지 사용


### 정적 리소스
스프링 부트는 클래스패스의 다음 디렉토리에 있는 정적 리소스를 제공한다.   
`/static` , `/public` , `/resources` ,`/META-INF/resources`

#### 정적 리소스 경로
`src/main/resources/static`

### 뷰 템플릿
뷰 템플릿을 거쳐서 HTML이 생성되고, 뷰가 응답을 만들어서 전달한다.

#### 뷰 템플릿 경로
`src/main/resources/templates`

### HTTP 메시지 사용
`@ResponseBody` , `HttpEntity` 를 사용하면, 뷰 템플릿을 사용하는 것이 아니라, HTTP 메시지 바디에 직접 응답 데이터를 출력할 수 있다.


## HTTP 응답 - HTTP API, 메시지 바디에 직접 입력
HTTP API를 제공하는 경우에는 HTML이 아니라 데이터를 전달해야 하므로, HTTP 메시지 바디에 JSON 같은 형식으로 데이터를 실어 보낸다.



### @ResponseBody
```java
@ResponseBody
@GetMapping("/response-body-string-v3")
public String responseBodyV3() {
    return "ok";
}
```
- `@ResponseBody` 를 사용하면 view를 사용하지 않고, HTTP 메시지 컨버터를 통해서 HTTP 메시지를 직접 입력할 수 있다. `ResponseEntity` 도 동일한 방식으로 동작한다.


### ResponseEntity
```java
@GetMapping("/response-body-json-v1")
public ResponseEntity<HelloData> responseBodyJsonV1() {
    HelloData helloData = new HelloData();
    helloData.setUsername("userA");
    helloData.setAge(20);
    return new ResponseEntity<>(helloData, HttpStatus.OK);
}
```
- `HttpEntity`는 HTTP 메시지의 헤더, 바디 정보를 가지고 있다.
- `ResponseEntity` 는 여기에 더해서 HTTP 응답 코드를 설정할 수 있다.

### @ResponseBody, @ResponseStatus
```java
@ResponseStatus(HttpStatus.OK)
@ResponseBody
@GetMapping("/response-body-json-v2")
public HelloData responseBodyJsonV2() {
     HelloData helloData = new HelloData();
     helloData.setUsername("userA");
     helloData.setAge(20);
     return helloData;
}
```
- `ResponseEntity` 는 HTTP 응답 코드를 설정할 수 있는데, `@ResponseBody` 를 사용하면 이런 것을 설정하기 까다롭다.
- `@Controller` 대신에 `@RestController` 애노테이션을 사용하면, 해당 컨트롤러에 모두 `@ResponseBody` 가 적용되는 효과가 있다.
  - `@RestController`= `@ResponseBody`+ `@Controller`




## HTTP 메시지 컨버터
뷰 템플릿으로 HTML을 생성해서 응답하는 것이 아니라, HTTP API처럼 JSON 데이터를 HTTP 메시지 바디에서 직접 읽거나 쓰는 경우 HTTP 메시지 컨버터를 사용하면 편리하다.

스프링 MVC는 다음의 경우에 HTTP 메시지 컨버터를 적용한다.
- HTTP 요청: `@RequestBody` , `HttpEntity(RequestEntity)` 
- HTTP 응답: `@ResponseBody` , `HttpEntity(ResponseEntity)`


### 스프링 부트 기본 메시지 컨버터
```java
0 = ByteArrayHttpMessageConverter        // 클래스 타입: `byte[]` , 미디어타입: `*/*`
1 = StringHttpMessageConverter           // 클래스 타입: `String` , 미디어타입: `*/*`
2 = MappingJackson2HttpMessageConverter  //클래스 타입: 객체 또는 `HashMap` , 미디어타입 `application/json` 관련
```

### HTTP 요청 데이터 읽기
1. HTTP 요청이 오고, 컨트롤러에서 `@RequestBody` , `HttpEntity` 파라미터를 사용한다.
2. 메시지 컨버터가 메시지를 읽을 수 있는지 확인하기 위해 `canRead()` 를 호출한다.
   - 대상 클래스 타입을 지원하는가.
   - HTTP 요청의 Content-Type 미디어 타입을 지원하는가.
3. `canRead()` 조건을 만족하면 `read()` 를 호출해서 객체 생성하고, 반환한다.

### HTTP 응답 데이터 생성
1. 컨트롤러에서 `@ResponseBody` , `HttpEntity` 로 값이 반환된다.
2. 메시지 컨버터가 메시지를 쓸 수 있는지 확인하기 위해 `canWrite()` 를 호출한다.
   - 대상 클래스 타입을 지원하는가.
   - HTTP 요청의 Accept 미디어 타입을 지원하는가.
3. `canWrite()` 조건을 만족하면 `write()` 를 호출해서 HTTP 응답 메시지 바디에 데이터를 생성한다.


## 요청 매핑 헨들러 어뎁터 구조

### RequestMappingHandlerAdapter 동작 방식






























