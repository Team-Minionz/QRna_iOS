# QRna
QR 체크인을 이용한 매장의 혼잡도 제공 서비스

## 👨‍👧‍👦 Team Minions

### 백엔드

🧑🏻‍💻 [정재욱](https://github.com/malpipapi)

👨🏻‍💻 [이동현](https://github.com/DongLee99)

👩🏻‍💻 [어정윤](https://github.com/jeongyuneo)

### 안드로이드

👨🏻‍💻 [임가람](https://github.com/garam918)

### iOS

👨🏻‍💻 [이명직](https://github.com/LeeMyungJic)

## 🤔 Why?

다들 한번쯤은 코로나가 두려워 사람이 많은 매장, 지역을 피해다닌적이 있을것이다. 나 또한 그랬다. 일일 확진자가 1~2000명을 육박하는 지금 일반인들이 할 수 있는 가장 기초적인 방역 수단은 사람 많은 곳을 피해 다니고 마스크를 잘 착용하는 것이다. 하지만 사람들이 지금 어느 매장이 얼마나 붐비는지 알기 위해서는 직접 가서 확인해 보는 방법 밖에 없다.

포스트 코로나 시대에는 언택트 문화는 지속될 것이라는 전문가들의 전망이 나오고 있으며 새로운 전염병을 대비해 대책을 세우기 위해 방문 기록은 다양한 형태로 발전할 것이라고 예상한다. 또한 코로나로 인해 인파가 많은 곳을 방문하는 것을 기피하는 사람들이 늘어났으나 현재는 매장들에 대한 혼잡도를 제공해주는 서비스가 대중화 되어 있지 않다. 이에 현재 방문 기록을 작성하는 QR코드 인증 방식이 그저 방문 기록만을 목적으로 사용하는 것이 아닌 이를 이용해 다양한 서비스를 개발할 수 있겠다는 생각이 들었다.

QR 인증을 통해 매장 방문기록을 남기는 것은 현재 매장을 사용 중이라는 것을 의미한다. QR 인증을 카운트 값으로 가져 오면 해당 매장의 혼잡도를 파악하는 서비스를 개발할 수 있다. 사용자는 이 서비스를 통해 가고자 하는 매장의 혼잡도를 파악하여 방문할 매장 선택에 도움을 받을 수 있다.

## 😪 What?

주요 **기능**

1. 메인
    - 전체 매장 리스트
    - 혼잡 정도를 확인하고자 하는 매장 검색
2. 로그인
    - 자체 로그인
    - 간편 로그인(카카오톡, 네이버)
3. 방문 기록
    - QR 인증(이름, 전화번호, 소재지)
4. 매장 정보
    - 상호명
    - 전화번호
    - 소재지
    - 혼잡도(원활/보통/혼잡)

추가 기능

1. 전일/금일 확진자 수 정보 제공
2. 사용자 위치의 거리두기 단계 정보 제공

## ‼️ Problem

- ~~매장별 입장시간을 기준으로 퇴장을 몇 분으로 잡을 것인가?~~
  → 테이블 주문 완료 시 테이블 사용 상태를 미사용 표기

- ~~혼잡의 기준~~
  → 매장 총 수용 가능 인원과 테이블 사람 수를 카운트해서 비율을 정해 혼잡도를 표기
  
- 혼잡도 기능을 추가 시 중복 방문 요청에 처리 기능 추가해야 함.

## 기술 스택

- `Swift 5`,  `Xcode 12`
- `Moya`,  `MVVM Pattern`, `Delegate Pattern` 
- `DropDwon`

## 기간

2021.10.04 ~ 

---

## 개발일지

- #### Cell 개수에 따른 TableView 동적 높이

  ~~~ swift
  class IntrinsicTableView: UITableView {
      override var intrinsicContentSize: CGSize {
          // number : cell 개수
          let number = numberOfRows(inSection: 0)
          var height: CGFloat = 0
  
        
          for i in 0..<number {
              guard let cell = cellForRow(at: IndexPath(row: i, section: 0)) else {
                  continue
              }
              // cell의 높이만큼 계속 더함
              height += cell.bounds.height
          }
          return CGSize(width: contentSize.width, height: height)
      }
  }
  ~~~

  

- #### frame VS bounds

  - frame

    - 핵심은 SuperView(상위뷰)
    - A뷰(SuperView)와 B뷰(SubView)가 있을 때~
    - B뷰의 frame을 확인해보면 A뷰의 좌상단으로 부터 얼마만큼 떨어져 있는지 볼 수 있다
      - ex) frame이 120, 20 이라면 SuperView로부터 x는 120, y는 20만큼 떨어져 있다
      - origin을 0, 0으로 바꾸면 Super뷰의 좌상단에 맞춰짐
    - SuperView는 바로 상위의 View다 (최상위 뷰가 아님)

  - bounds

    - 핵심은 자신만의 좌표 시스템

    - SuperView의 bounds 값을 주면, 화면상으로는 SubView가 움직인 것처럼 보임

      

- #### DropDown

  - pod file에 DropDown 추가

  ~~~ swift
  class JoinViewController {
    // DropDown 선언
    let dropDown = DropDown()
    
    fileprivate func setDropDownBtn() {
      	  // dropDown에 보여줄 데이터 설정
          dropDown.dataSource = ["유저", "점주"]
      		// 보여줄 위치 설정 (이렇게 하면 userTypeBtn 바로 아래에 보여줌)
          dropDown.anchorView = userTypeBtn
          dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
          
      		// 데이터 view의 cornerRadius 설정
          DropDown.appearance().cornerRadius = 8
      }
    // 사용
    @IBAction func didTapUserTypeBtn(_ sender: Any) {
      		// .show() 메소드로 버튼을 클릭하면 dropDown을 보여줌
          self.dropDown.show()
    }
    // 하위 데이터 클릭시 이벤트 처리
    override func viewDidLoad() {
          super.viewDidLoad()
      
      		dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              // 해당 Index와 item(string 값)에 접근 가능
          }
    }
  }
  
  
  ~~~

  

- #### 공백 체크 (회원가입, 매장등록 등)

  ~~~ swift
  // 판단할 textField 들을 모두 담은 배열로 판단
  fileprivate func checkEmpty(_ textFeilds: [UITextField]) -> Bool{
      for textFeild in textFeilds {
          // 하나라도 공백이 발견되면 false 값을 리턴
          if textFeild.text == "" {
              return false
          }
      }
      return true 
  }
  
  // 사용
  var textFields = [UITextField]()
  textFields.append(storeName)
  textFields.append(storeNumber)
  textFields.append(city)
  textFields.append(detailCity)
  textFields.append(street)
  textFields.append(zipCode)
          
  if checkEmpty(textFields) {
       // 체크 후 처리할 로직
  }
  else {
       // 공백 발견 시 처리할 로직
  }
  ~~~

  

- #### 매장 등록 - 테이블 계산

  - 딕셔너리를 사용하는 것이 효율적이지만, 딕셔너리로 하면 데이터 추가 후 테이블을 reloadData()를 할 때 순서가 바뀔 수 있음
  - 딕셔너리는 값을 순서대로 가져오는 것이 아니라 랜덤으로 가져옴

  ~~~ swift
  // 테이블 중복 확인 후 계산
  // ex) 2인 테이블이 이미 있는데 2인 테이블을 또 추가한다면 append 하지 않고 이미 있는 값에 더해줘야 함
  fileprivate func checkDuplicationAndSetArray(_ numberOfPeople: Int, _ numberOfTable: Int){
      var index = 0
      for item in tableArray {
          // 같은 테이블이 있을 경우 그 인덱스에 인원 수 추가
          if item.peopleCount == numberOfPeople {
              tableArray[index].tableCount += numberOfTable
              return
          }
          index += 1
      }
      // 중복이 없다면 새로운 값을 추가해줌
      tableArray.append(TableInfo(tableCount: numberOfTable, peopleCount: numberOfPeople))
  }
  ~~~

  


