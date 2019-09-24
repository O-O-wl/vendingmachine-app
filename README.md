## 음료 자판기 앱 📱

<br>

### Step1 

#### iOS App Launch

<img width="522" alt="Launch-0" src="https://user-images.githubusercontent.com/39197978/65477636-e3001a80-dec1-11e9-8a86-d9701cad4a23.png">



- 기본적으로 iOS앱은 `UIApplication` 객체이다.

  - macOS와 마찬가지로 `main`함수로 부터 프로그램의 흐림이 시작된다. (다만 숨겨져 있다.)

  <img width="340" alt="스크린샷 2019-09-23 오후 11 41 54" src="https://user-images.githubusercontent.com/39197978/65436098-8d455700-de5c-11e9-8014-e249645941ec.png">

  - ` main` 함수에서 `UIApplicatoinMain() `함수를 호출해서 `UIApplication` 객체가 생성된다.
  - 그 직후 `AppDelegate` 또한 초기화된다

  <img width="340" alt="스크린샷 2019-09-23 오후 11 42 18" src="https://user-images.githubusercontent.com/39197978/65436101-8d455700-de5c-11e9-9fce-d71d395528fe.png">

  - 이 후 `RunLoop`가 실행된다.

<img width="340" alt="스크린샷 2019-09-23 오후 11 59 48" src="https://user-images.githubusercontent.com/39197978/65437268-79025980-de5e-11e9-9627-9122dadb0e57.png">

![IMG_1006](https://user-images.githubusercontent.com/39197978/65477590-b946f380-dec1-11e9-8c7c-a71047c26e86.PNG)

#### Main Run Loop

- 앱이 시작한 이 후 MainRunLoop 가 실행된다.
- 사용자의 입력(액션) 시스템에 의해 이벤트화 된다.
- 이벤트는 **UIkit** 에서 미리 생성해둔 **Port를** 통해 앱에 전달이 된다.
- 이벤트는 **Event queue** 에 저장된다.
- 이벤트 큐에서 하나씩 Main run Loop가 이벤트를 처리한다.
- 처리후 결과를 **View**에 전달한다.

 

---

