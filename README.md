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



#### STEP2 : 피드백 및 개선

---

#### 피드백 #1 🤔

>Money 객체가 **struct 인가 class 인가 따라서 여기 핸들러에서 값이 바뀔수도 있고 아닐 수도** 있습니다.
>클로저로 작성할 때 **매개변수가 class 인 경우는 수정가능**하기 때문에 주의해야 합니다.
>내부 속성을 열어놓은 것과 크게 다르지 않습니다.

- **나의 생각과 고민  💬**

  -  배열과 같은 클로저를 주입받는 객체들은 클로저를 주입받아
    새로운 데이터를 생성해서 반환하는 것이지, **내부 데이터를 직접 수정하는 동작을 하지는 않는다**는 것을 알았다.
  - struct로 해두면 내부 데이터를 핸들링하는 클로저를 주입하는 것을 방어하기때문에 그렇게 구현해야한다는 것을 알았다. 이 부분을 주의해야 할 것같다.

  <br>

#### 피드백 #2 🤔

>```swift
>extension UIView {
>    func edgeTrim() {
>        self.layer.cornerRadius = 10
>    }
>```
>
>이렇게 기존 타입을 확장하는 경우에는 모든 경우에 적용가능한 것인지, 
>
>**일부 하위 타입에만 적용하는 것인지 판단**해서
>가능한 적은 범위의 구체적인 타입만 확장하는 게 좋습니다. 참고하세요.

- **나의 생각과 고민  💬**
  - `UIView` 전체에서 사용되는 거라면 이런 확장이 용납되나 특정 custom cell 에서만 사용되는 속성이었다면 확장으로 표현하는 것이 좋은 선택이 아니었던 것 같다.
  - 너무 extension을 남발한 것 같다.

<br>

### 피드백 #3 🤔

>```swift
>override func awakeFromNib() {
>        super.awakeFromNib()
>        self.edgeTrim() // cell 자체를 핸들링
>```
>
>UICollectionViewCell 을 rounded corner로 만들면 생기는 부작용은 없나요?
>예를 들어 선택할 때 background view 처리나 콘텐츠 뷰 자체에 영향을 주는 경우가 있습니다.

- **나의 생각과 고민  💬**
  - `contentView`를  `TableViewCell` 의 경우 editMode 에 들어가면 `contentView`의 크기가  자체 크기를 조절한다는 차이점이 있다





## Step3

![Oct-18-2019 15-39-15](https://user-images.githubusercontent.com/39197978/67071445-842a7a00-f1bd-11e9-8a8f-3a9d4f0a1bdd.gif)



**Archieve**

객체의 그래프를 저장할 수 있는 방법을 학습했다.

직렬화 를 통해서도 객체를 저장할 수 있으나  직렬화는 객체의 값에만 관심을 가지기때문에, 객체를 식별하지 않는다.

그래서 양방향 참조를 가진 객체의 경우 사이클이 발생할수도 있다. 

> #### 직렬화
>
> 부엉이는 A학교에 다닌다. 그래서 부엉이는 A학교를 참조한다
>
> A학교는 부엉이라는 학생이 있다. 그래서 부엉이를 참조한다.
>
> 부엉이라는 객체를 저장하자.
>
> 부엉이를 직렬화하는 과정에서 A학교를 직렬화해야한다. 그런데 
>
> A학교에는 부엉이가 다닌다. 그래서 부엉이를 또 직렬화 하고 
>
> A학교 -> 부엉이 -> A학교 -> 부엉이 -> … 과 같은 계속적인 복사가 일어나서 
>
> 사이클이 발생한다. 



하지만 아카이빙은 다르다. 아카이빙은 객체의 값이 아니라 객체 그 자체에 관심을 가진다.



>#### 아카이빙
>
>부엉이는 A학교에 다닌다. 그래서 부엉이는 A학교를 참조한다
>
>A학교는 부엉이라는 학생이 있다. 그래서 부엉이를 참조한다.
>
>부엉이라는 객체를 저장하자.
>
>부엉이를 아카이빙하는 과정에서 A학교를 아카이빙해야한다. 그런데 
>
>A학교에는 부엉이가 다닌다. 
>
>이때 이 부엉이는 아카이빙하던 객체와 동일한 객체이다.
>
>그래서 다시 아카아빙을 하지않는다.



**`NSCoding` -** 객체의 깊은 복사

**`NSCopying`** - 객체의 얕은 복사 





내가 잘못알고 있던 부분이 있었다. 

```swift
var 원본 = 객체()
var 복사 = 원본
```

와 같이 참조를 공유하는 것을 얕은 복사라고 하는 줄 알았다.



```swift
var 원본 = NSMutableDictionary.init()
원본[0] = NSMutableArray(objects: NSString("original"),
                            NSString("original2"))

let 얕은복사 = 원본.mutableCopy() as! NSMutableDictionary

let 아카이빙데이터 = try! NSKeyedArchiver.archivedData(withRootObject: 원본,
                                             requiringSecureCoding: false)
let 깊은복사 = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(아카이빙데이터) as! NSMutableDictionary

원본 === 얕은복사 // print: false
원본 === 깊은복사 // print: false

원본 // print: original,original2
(얕은복사[0] as! NSMutableArray).add(NSString("Shallow Copy"))
(깊은복사[0] as! NSMutableArray).add(NSString("Deep Copy"))
원본 // print: original, original2, "Shallow Copy"
```

처럼 얕은복사본과 원본은 다른 객체이지만

내부 참조하고 있는 객체가 동일한 형태였다.

그래서 얕은복사본에서 내부 객체속성을 변경한다면, 원본에 영향을 끼쳤다.

그래서 오는 부작용때문에 `copy()` ,`mutableCopy()` 두가지 방식의 얕은 복사를 지원하는 듯하다.



`Beverage`객체에 `copy(zone:)` 메시지가 전달되지만 구현되지 않아서 자꾸 죽었다. 

친구의 도움으로 이게  `NSDictonary` 를 아카이빙하는 과정에서 `key`로 쓰는 객체는 `NSCopying`이 구현되어 있어야한다는 것을 들었다.

실제 `NSDictionary`를 보니 `init(coder:)`메소드에서  아래의` init`이 불렸으며 `key`들은 `copy`를 했다.

```swift
public required init(objects: UnsafePointer<AnyObject>!, forKeys keys: UnsafePointer<NSObject>!, count cnt: Int) {
        _storage = [NSObject : AnyObject](minimumCapacity: cnt)
        for idx in 0..<cnt {
            let key = keys[idx].copy()
            let value = objects[idx]
            _storage[key as! NSObject] = value
        }
    }

```

**key로 사용하는 객체는 안정적이어야해서 얕은복사이지만 immutable한 객체로 구현되어 있는 듯하다.**



## Step4

`VendingmahcinePresenter` 를 싱글턴으로 구현했다.

근데 구현을 하면서 느낀점은 **자기 자신의 생성을 자신이 책임**을 지다보니 너무 메소드가 커지는 것을 느꼈다.

그리고 이 경우에는 언아카이빙과 아카이빙에 대한 로직이 생성과 관련되어서 더욱 생성자가 커져서 언/아카이빙을 분리하고 싶었다.

그래서` UserDefaultsManager` 라는 `UserDefaults` 를 핸들링하는 객체 분리해냈다.

싱글턴을 객체와 구조체로 구현해보았다.

구조체는 엄밀히 말해서는 한 개의 인스턴스를 가지지는 않기에, 싱글턴이라고 말하기는 모호하지만, 비슷한 형태로 구현했다.

사실 전역메소드를 특정 네임스페이스에 가둬둔 형태로 구현했다.

```swift
protocol Saveable {
    static var key: String { get }
}

struct UserDefaultsManager {
    
    private init() {}
    
    static func load<T: Saveable>(type: T.Type) -> T? {
        guard
            let data = UserDefaults.standard.data(forKey: type.key),
            let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
            else { return nil }
        return value
    }
    
   static func save<T: Saveable>(object: T) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object,
                                                         requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: T.key)
        } catch let error {
            print("UserDefault Save Failure: \(error.localizedDescription)")
        }
        
    }
}
```

(언)아카이빙을 담당하는 구조체를 두었고, 또 다른 싱글턴 객체를 구현했다.



```swift
class VendingMachinePresenter: NSObject, NSCoding, Saveable {
	static var key: String {
	      return String(describing: self)
		 }

  static let shared: VendingMachinePresenter = {
     if
         let loaded = UserDefaultsManager.load(type: VendingMachinePresenter.self) {
         return loaded
     } else {
         return .init(balance: Money(value: 0),
                      inventory: Inventory(products: BeverageFactory.createAll(quantity: 0)),
                      history: History())
     }
 }()
```
그래서 조금 더 로직을 분리해냈다.

---

### Step4 - 피드백 및 개선

- #### 피드백 #1 🤔

[![@godrm](https://avatars0.githubusercontent.com/u/278988?s=60&v=4)](https://github.com/godrm) **godrm**

> `view.presenter = VendingMachinePresenter.shared`
> 이렇게 싱글톤 객체를 외부에서 넣어주면,
> 백그라운드에 들어갔다가 나올 때마다 `view.presenter` 와 `VendingMachinePresenter.shared`달라지지 않나요?
> 자판기 객체가 계속 바뀌는 현상이 생기지 않는지 확인해보세요.

- **나의 생각과 고민  💬**

  - 개인적으로 싱글턴객체가 중간에 reset 되야한다는 생각을 해본 적이 없었다. 하지만 충분히 가능한 상황들이 있을 것 같았다.

  - ```swift   
    
    class VendingMachinePresenter: NSObject, NSCoding {
        
        private static var _shared: VendingMachinePresenter?
        
        static var shared: VendingMachinePresenter {
            if let shared = _shared {
                return shared
            } else {
                _shared = UserDefaultsManager.load(type: VendingMachinePresenter.self)
            }
            return _shared ?? .init(balance: Money(value: 0),
                                    inventory: Inventory(products: BeverageFactory.createAll(quantity: 0)),
                                    history: History())
        }
      
      
        static func destory() {
            _shared = nil
        }
        
    ```

  - 위와 같이 개선했다. 하지만 실제 객체그래프를 찍어보니, Presenter가 살아있었다.

  - ```swift
    class VendingMachineViewController: UIViewController {
        
        // MARK: Properties
        unowned var presenter: VendingMachinePresenterType!
    ```

  - 위와 같이 싱글턴 객체는 자기 자신이 메모리관리를 하게하기위해서, 다른 부분에서는 unowned 하게 참조하게 개선하였다.



### Step5 

---

`NotificationCenter`를 이용해서  `ViewController`에서 바로 값을 가저와서 적용하게 하지 않고, 

특정 Notification을 관찰하게 구현을 했다.

```swift
// 구독하기
NotificationCenter.default.addObserver(self, 
                                       selector: #selector(eventDidOccured)
                                       name: NSNotociation.Name("event"), 
                                       object: nil)
// 알리기
NotificationCenter.default.post(name: NSNotociation.Name("event"), 
                                object: nil)
```

의 형태로 구현을 하는 데,  name이 구독과 알림을 결정하는 중요한 키가 된다.
하지만 `String`형태로 구현되어 있으면 미스타이핑이 충분히 일어날 수 있고, 또 수정시 `addObserver / post` 부분의 키워드를 모두 변경해야하는  불안한 형태의 코드라고 생각되어 이 부분만 조금 개선해보았다.

```swift
protocol NotificationConvertable {
    var name: NSNotification.Name { get }
}

enum AppEvent: String, NotificationConvertable {
    case productsDidChanged
    case balanceDidChanged
    case historyDidChanged
    
    var name: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }
}
```

열거형으로 구현함으로써, `Notification.Name`키워드의 변경을 한 곳에서 관리할 수 있게 변경했다.



**KVO vs Delegation vs NotificationCenter** 

다른 두 객체간의 소통 방법을 구현하는 방식인데 작은 차이들이 있어 이 부분은 추후 공부해야할 것 같다. 

<br>

## Step6

![Oct-26-2019 01-00-03](https://user-images.githubusercontent.com/39197978/67586228-20d7b380-f78c-11e9-960e-9cb8a14a5975.gif)



해당 스탭에서 구매한 물품을 뷰로 보여줘야하는 요구사항이 추가되었고,

메인 `View`에 `CollectionView` 가 2개나 되는 형태가 되어서,  메인 `ViewController`가 두개의 `CollectionView`에 대한 `Delegate / DataSource` 역할을 다 하게하니 해당 메소드들이 커졌다.

그래서 이 부분을 개선하기 위해서 각각의 뷰를 핸들링하는 관리자 객체를 분리했다.