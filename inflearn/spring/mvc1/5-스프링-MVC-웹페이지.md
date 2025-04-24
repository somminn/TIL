# 스프링 MVC 웹 페이지

서비스 제공 흐름

부트스트랩
부트스트랩(Bootstrap)은 웹사이트를 쉽게 만들 수 있게 도와주는 HTML, CSS, JS 프레임워크이다. 
하나의 CSS로 휴대폰, 태블릿, 데스크탑까지 다양한 기기에서 작동한다. 
다양한 기능을 제공하여 사용자가 쉽게 웹사이 트를 제작, 유지, 보수할 수 있도록 도와준다.

BasicItemController
```java
@Controller
@RequestMapping("/basic/items")
@RequiredArgsConstructor
public class BasicItemController {
     private final ItemRepository itemRepository;
     
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
- `@RequiredArgsConstructor`: final 붙은 멤버변수로 생성자를 만든다.
- `@GetMapping`: 요청 정보 매핑 + GET 메서드
- `@PostConstruct`: 요청 정보 매핑 + POST 메서드

