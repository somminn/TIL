# 스프링 MVC - 구조 이해 


SpringMVC 구조
![SpringMVC 구조]()

동작 순서
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




DispatcherServlet 구조 살펴보기
스프링 MVC의 프론트 컨트롤러가 바로 `DispatcherServlet`이다.
스프링 부트는 `DispatcherServlet` 을 서블릿으로 자동으로 등록하면서 모든 경로(`urlPatterns="/"`)에 대해서 매핑한다.
`DispatcherServlet`이 모든 요청을 먼저 받아서 필요한 핸들러(컨트롤러나 정적 리소스 등)로 전달한다.

DispatcherServlet.doDispatch()
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


주요 인터페이스 목록
스프링 MVC는 대부분의 기능들을 인터페이스로 제공하기때문에 `DispatcherServlet` 코드의 변경 없이, 원하는 기능을 변경하거나 확장할 수 있다.
- 핸들러 매핑: `org.springframework.web.servlet.HandlerMapping`
- 핸들러 어댑터: `org.springframework.web.servlet.HandlerAdapter` 
- 뷰 리졸버: `org.springframework.web.servlet.ViewResolver`
- 뷰: `org.springframework.web.servlet.View`

핸들러 매핑과 핸들러 어댑터

스프링 부트가 자동 등록하는 핸들러 매핑과 핸들러 어댑터
HandlerMapping
```java
0 = RequestMappingHandlerMapping    : 애노테이션 기반의 컨트롤러인 @RequestMapping에서 사용
1 = BeanNameUrlHandlerMapping       : 스프링 빈의 이름으로 핸들러를 찾는다.
```

HandlerAdapterm,                                                                               
```java
 0 = RequestMappingHandlerAdapter   : 애노테이션 기반의 컨트롤러인 @RequestMapping에서 사용 
 1 = HttpRequestHandlerAdapter      : HttpRequestHandler 처리
 2 = SimpleControllerHandlerAdapter : Controller 인터페이스(애노테이션X, 과거에 사용) 처리
```


OldController
```java
public interface Controller {
    ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
```
HandlerMapping = BeanNameUrlHandlerMapping
HandlerAdapter = SimpleControllerHandlerAdapter

HttpRequestHandler: 서블릿과 가장 유사한 형태의 핸들러이다.
```java
public interface HttpRequestHandler {     
    void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
```
HandlerMapping = BeanNameUrlHandlerMapping
HandlerAdapter = HttpRequestHandlerAdapter




뷰 리졸버
스프링 부트는 `InternalResourceViewResolver` 라는 뷰 리졸버를 자동으로 등록한다.
`application.properties` 에 등록한 `spring.mvc.view.prefix` , `spring.mvc.view.suffix` 설정 정보를 사용해서 등록한다.


**스프링 부트가 자동 등록하는 뷰 리졸버**
```java
1 = BeanNameViewResolver         : 빈 이름으로 뷰를 찾아서 반환한다. (예: 엑셀 파일 생성 기능 에 사용)
2 = InternalResourceViewResolver : JSP를 처리할 수 있는 뷰를 반환한다.
```





스프링 MVC - 시작하기


@RequestMapping

스프링에서 주로 사용하는 애노테이션 기반의 컨트롤러를 지원하는 핸들러 매핑과 어댑터
`RequestMappingHandlerMapping` 
`RequestMappingHandlerAdapter`
실무에서는 99.9% 이 방식의 컨트롤러를 사용한다.