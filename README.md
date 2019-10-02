## 음료 자판기 앱 📱

<br>

## Step1 

---

#### iOS App Launch

<img width="522" alt="Launch-0" src="https://user-images.githubusercontent.com/39197978/65477636-e3001a80-dec1-11e9-8a86-d9701cad4a23.png">



- 기본적으로 iOS앱은 `UIApplication` 객체이다.

  - macOS와 마찬가지로 `main`함수로 부터 프로그램의 흐림이 시작된다. (다만 숨겨져 있다.)

  <img width="340" alt="스크린샷 2019-09-23 오후 11 41 54" src="https://user-images.githubusercontent.com/39197978/65436098-8d455700-de5c-11e9-8014-e249645941ec.png" align="center">

  - ` main` 함수에서 `UIApplicatoinMain() `함수를 호출해서 `UIApplication` 객체가 생성된다.
  - 그 직후 `AppDelegate` 또한 초기화된다

  <img width="340" alt="스크린샷 2019-09-23 오후 11 42 18" src="https://user-images.githubusercontent.com/39197978/65436101-8d455700-de5c-11e9-9fce-d71d395528fe.png" align="center">

  - 이 후 `RunLoop`가 실행된다.

  

<img width="340" alt="스크린샷 2019-09-23 오후 11 59 48" src="https://user-images.githubusercontent.com/39197978/65437268-79025980-de5e-11e9-9627-9122dadb0e57.png" align="center">

<br>

![IMG_1006](https://user-images.githubusercontent.com/39197978/65477590-b946f380-dec1-11e9-8c7c-a71047c26e86.PNG)

#### Main Run Loop

- 앱이 시작한 이 후 MainRunLoop 가 실행된다.
- 사용자의 입력(액션) 시스템에 의해 이벤트화 된다.
- 이벤트는 **UIkit** 에서 미리 생성해둔 **Port를** 통해 앱에 전달이 된다.
- 이벤트는 **Event queue** 에 저장된다.
- 이벤트 큐에서 하나씩 Main run Loop가 이벤트를 처리한다.
- 처리후 결과를 **View**에 전달한다.

 

---

<br>

## Step2

---

![iPad VendingMachine](https://user-images.githubusercontent.com/39197978/65745870-1ba92980-e138-11e9-8ed4-9004b5b7f8ee.gif)



- **View**

- ```swift
  protocol VendingMachineView {
      func displayProducts()
      func displayBalance()
  }
  ```

- **Presenter**

- ```swift
  protocol VendingMachinePresenterType: MoneyHandleable {
      var numOfRow: Int { get }
      func configure(cell: ProductCellType, index: Int)
      func setStrategy(_ strategy: StateHandleable?)
      func execute() throws
  }
  ```

  



MVP 패턴을 자판기 앱에 적용하면서 느낀 점은 내가 이전에 했던 콘솔프로젝트에서 가져온 클래스 **`VendingMahcine `**의 이름이 Presenter 만 아니었을 뿐이지 그 역할을 하기에 충분했다. 게다가 프레젠터가 뷰를 몰라도 되는 구조였다. 

이러한 패턴은 어떤 패턴인지 모르겠으나, 이벤트핸들링(스트래티지)을 하는 로직을 생성하는 팩토리 객체가 있고,

뷰는 팩토리와 협력해 스트래티지를 생성한 후 프레젠터에게 로직을 주입해주는 작업을 취했다. 

프레젠터는 그 로직을 받아 모델의 데이터를 핸들링하고, 

핸들링한 결과를 다시 뷰에게 전달해주는데 이 과정에서 뷰는 자신에게 어떻게 그려져야하는 지를 알고 있어서, 

그걸 클로저로 주입해줘셔 사실상 **프레젠터와 뷰 간의 단방향 의존성**만 생기는 점에서 조금 다르게 느껴졌다.  

셀프 체크리스트를 적용하지 못한 점이 아쉽다. 구현하고 싶은 마음이 커서 빠르게 하다보니 체크하지 못했다.

