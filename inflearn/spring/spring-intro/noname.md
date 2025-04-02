### 자동 빌드 설정하기 (devtools)
#### 0. 경위 
java 파일을 수정하고 빌드하는 것이 번거로워 파일 수정 시 자동으로 빌드해주는 devtools 설정을 추가했다.

#### 1. 자동 빌드 설정1
`Settings | Build, Execution, Deployment | Compiler`  
Build project automatically 체크

#### 2. 자동 빌드 설정2
`Settings | Advanced Settings`  
Allow auto-make to start even if developed application is currently running 체크

#### 3. build.gradle 에 의존성 추가
```java
developmentOnly 'org.springframework.boot:spring-boot-devtools'
```
#### 4. 인텔리 제이 재기동

#### 5. 변경 확인 방법 
java 파일 변경 후 [  restartedMain] 로그 확인


### 터미널에서 빌드하고 실행하기
1. 빌드
```java
./gradlew build
```
2. 실행
```java
cd build/libs
java -jar hello-spring-0.0.1-SNAPSHOT.jar
```
