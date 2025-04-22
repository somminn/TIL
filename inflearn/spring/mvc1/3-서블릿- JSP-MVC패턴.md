# 서블릿
- 뷰(View)화면을 위한 HTML을 만드는 작업이 자바 코드에 섞여서 지저분하고 복잡했다.
- JSP를 사용한 덕분에 뷰를 생성하는 HTML 작업을 깔끔하게 가져가고, 중간중간 동적으로 변경이 필요한 부분에만 자 바 코드를 적용했다.

# JSP
java 파일에 html을 넣는건 위험 부담이 커 동적 html 기능만 jsp파일로 작성하여 사용한다.
- JSP: HTML에 Java 코드를 섞을 수 있는 템플릿 (동적 웹페이지 생성)
- HTML: 정적인 웹 문서 (기본적인 웹페이지 구조)

#### jsp 파일에 자바 코드 넣기
`<% ~ %>`

#### jsp 파일에서 주석 처리
1. `<%-- --%>` : 브라우저 화면에서 안보임 / 소스 보기에서 안보임
2. `<!-- -->` : 브라우저 화면에서 안보임 / 소스 보기에서 보임
- 참고로 // 는 자바 주석이므로 적용 안됨


# 서블릿과 JSP의 한계
- JSP가 너무 많은 역할을 한다.
- 비즈니스 로직(자바)과 뷰 렌더링(html)를 분리하는 것이 필요
- 비즈니스 로직(자바)과 뷰 렌더링(html)를 분리하는 것이 필요 → MVC 패턴 등장

# MVC
## MVC 패턴 - 기본
비즈니스 로직은 서블릿 처럼 다른곳에서 처리하고, JSP는 목적에 맞게 HTML로 화면(View)을 그리는 일에 집중하도록 하자.

### 1. 너무 많은 역할
하나의 서블릿이나 JSP만으로 비즈니스 로직과 뷰 렌더링까지 모두 처리하게 되면, 너무 많은 역할을 하게되고, 결과적으로 유지보수가 어려워진다.

### 2. 변경의 라이프 사이클
- 둘 사이에 변경의 라이프 사이클이 다르다는 점이다.
- 예를 들어서 UI를 일부 수정 하는 일과 비즈니스 로직을 수정하는 일은 각각 다르게 발생할 가능성이 매우 높고 대부분 서로에게 영향을 주지 않는다.

### 3. 기능 특화
특히 JSP 같은 뷰 템플릿은 화면을 렌더링 하는데 최적화 되어 있기 때문에 이 부분의 업무만 담당하는 것이 가장 효과적이다.

### 4. Model View Controller
MVC 패턴은 지금까지 학습한 것 처럼 하나의 서블릿이나, JSP로 처리하던 것을 컨트롤러(Controller)와 뷰(View)라는 영역으로 서로 역할을 나눈 것을 말한다.
- `컨트롤러`: HTTP 요청을 받아서 파라미터를 검증하고, 비즈니스 로직을 실행한다. 그리고 뷰에 전달할 결과 데이터를 조회해서 모델에 담는다. 
- `모델`: 뷰에 출력할 데이터를 담아둔다. 뷰가 필요한 데이터를 모두 모델에 담아서 전달해주는 덕분에 뷰는 비즈니스 로직이나 데이터 접근을 몰라도 되고, 화면을 렌더링 하는 일에 집중할 수 있다. 
- `뷰`: 모델에 담겨있는 데이터를 사용해서 화면을 그리는 일에 집중한다. 여기서는 HTML을 생성하는 부분을 말한다.

## MVC 패턴 - 적용
`/WEB-INF`: 이 경로안에 JSP가 있으면 외부에서 직접 JSP를 호출할 수 없다. 우리가 기대하는 것은 항상 컨트롤러를 통해서 JSP를 호출하는 것이다.

## MVC 패턴 - 한계
1. 포워드 중복: View로 이동하는 코드가 항상 중복 호출되어야 한다. 
2. ViewPath 중복
3. 사용하지 않는 코드 
4. 공통 처리가 어렵다. → 프론트 컨트롤러(Front Controller) 패턴 도입

## 프론트 컨트롤러 
- 프론트 컨트롤러 서블릿 하나로 클라이언트의 요청을 받음 
- 프론트 컨트롤러가 요청에 맞는 컨트롤러를 찾아서 호출 
- 공통 처리 가능 
- 프론트 컨트롤러를 제외한 나머지 컨트롤러는 서블릿을 사용하지 않아도 됨


## V1 - 프론트 컨트롤러 도입
목표: 기존 코드를 최대한 유지하면서, 프론트 컨트롤러를 도입

![v1](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-18%20%EC%98%A4%ED%9B%84%2011.31.51.png?raw=true)
### urlPatterns
`urlPatterns = "/front-controller/v1/*"` : `/front-controller/v1` 를 포함한 하위 모든 요청은 이 서블릿에서 받아들인다. 

### controllerMap
  - key: 매핑 URL 
  - value: 호출될 컨트롤러

### service()
- `requestURI` 를 조회해서 실제 호출할 컨트롤러를 `controllerMap` 에서 찾는다.
- 컨트롤러를 찾고 `controller.process(request, response);` 을 호출해서 해당 컨트롤러를 실행한다.


## V2 - View 분리
목표: 컨트롤러에서 뷰로 이동하는 부분에 있는 중복을 없애기 위해 별도로 뷰를 처리하는 객체(MyView)를 만들자.

![v2](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-18%20%EC%98%A4%ED%9B%84%2011.42.05.png?raw=true)

## V3 - Model 추가
### 목표
1. 서블릿 종속성 제거: 요청 파라미터 정보는 자바의 Map으로 대신 넘기도록 하면 지금 구조에서는 컨트롤러가 서블릿 기술을 몰라도 동작할 수 있다.
2. 뷰 이름 중복 제거: 컨트롤러는 뷰의 논리 이름을 반환하고, 실제 물리 위치의 이름은 프론트 컨트롤러에서 처리하도록 단순화 하자.
3. ModelView: 서블릿의 종속성을 제거하기 위해 Model을 직접 만들고, 추가로 View 이름까지 전달하는 객체를 만들어보자.

![v3](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-18%20%EC%98%A4%ED%9B%84%2011.44.21.png?raw=true)
### 뷰 리졸버
```html
MyView view = viewResolver(viewName)
```
컨트롤러가 반환한 논리 뷰 이름을 실제 물리 뷰 경로로 변경한다. 그리고 실제 물리 경로가 있는 MyView 객체를 반환 한다.
- 논리 뷰 이름: `members`
- 물리 뷰 경로: `/WEB-INF/views/members.jsp`

```html
view.render(mv.getModel(), request, response)
```
- 뷰 객체를 통해서 HTML 화면을 렌더링 한다.
- 뷰 객체의 `render()` 는 모델 정보도 함께 받는다.
- JSP는 `request.getAttribute()` 로 데이터를 조회하기 때문에, 모델의 데이터를 꺼내서 `request.setAttribute()` 로 담아둔다. 
- JSP로 포워드 해서 JSP를 렌더링 한다.


## V4 - 단순하고 실용적인 컨트롤러
목표: 컨트롤러가 `ModelView` 를 반환하지 않고, `ViewName` 만 반환한다.

![v4](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-18%20%EC%98%A4%ED%9B%84%2011.48.32.png?raw=true)
### 모델 객체 전달
```html
Map<String, Object> model = new HashMap<>();
```
모델 객체를 프론트 컨트롤러에서 생성해서 넘겨준다. 컨트롤러에서 모델 객체에 값을 담으면 여기에 그대로 담겨있게 된다.

### 뷰의 논리 이름을 직접 반환
```html
String viewName = controller.process(paramMap, model);
MyView view = viewResolver(viewName);
```
컨트롤로가 직접 뷰의 논리 이름을 반환하므로 이 값을 사용해서 실제 물리 뷰를 찾을 수 있다.


## V5 - 유연한 컨트롤러
![v5](https://github.com/somminn/TIL/blob/main/image/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202025-04-19%20%EC%98%A4%EC%A0%84%2012.03.50.png?raw=true)
- `핸들러 어댑터`: 여기서 어댑터 역할을 해주는 덕분에 다양한 종류의 컨트롤러를 호출할 수 있다.
- `핸들러`: 컨트롤러의 이름을 더 넓은 범위인 핸들러로 변경했다. 어떠한 것이든 해당하는 종류의 어댑터만 있으면 다 처리할 수 있기 때문이다.

### 어댑터 패턴
어댑터 패턴을 사용하면 프론트 컨트롤러가 다양한 방식의 컨트롤러를 처리할 수 있다.

### 컨트롤러(Controller) 핸들러(Handler)
이제는 어댑터를 사용하기 때문에, 컨트롤러 뿐만 아니라 어댑터가 지원하기만 하면, 어떤 것이라도 URL에 매핑해서 사용할 수 있다. 그래서 이름을 컨트롤러에서 더 넒은 범위의 핸들 러로 변경했다.

### 매핑 정보
```html
private final Map<String, Object> handlerMappingMap = new HashMap<>();
```
매핑 정보의 값이 `ControllerV3` , `ControllerV4` 같은 인터페이스에서 아무 값이나 받을 수 있는 `Object` 로 변경되었다.




## 세 개의 Map

|이름 | 타입 | 만드는 주체 | 역할|
|:--|:--|:--|:--|
|handlerMappingMap | Map<String, Object> | 프론트 컨트롤러에서 미리 등록 | URL → 컨트롤러(핸들러) 매핑. 어떤 컨트롤러를 실행할지 결정|
|paramMap | Map<String, String> | 어댑터에서 요청 파라미터 추출 | 클라이언트 요청의 HTTP 파라미터 담은 것 (username=kim)|
|model | Map<String, Object> | 컨트롤러 내부에서 채움 | 뷰로 전달할 결과 데이터 (회원 리스트, 성공 메시지 등)|


흐름으로 이해해보기
```html
GET /front-controller/v5/v3/members/save?username=kim

```
1. handlerMappingMap
```html
handlerMappingMap.get("/front-controller/v5/v3/members/save")
```
→ MemberSaveControllerV3 반환됨
2. paramMap
```html
paramMap = { 
    "username" : "kim" }
```
→ 어댑터가 request에서 추출해서 컨트롤러에 넘겨줌

3. model
```html
ModelView mv = new ModelView("save-result");
mv.getModel().put("username", "kim"); 
```
→ 컨트롤러 내부에서 결과를 뷰에 넘기기 위해 채움

