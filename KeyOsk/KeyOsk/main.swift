import Foundation

protocol Menu {
    var name: String { get }
    var price: Double { get }
    
    func displayInfo()
    
    var explain: String { get }
}

extension Menu {
    var explain: String {
        return ""
    }
    func displayInfo() {
        print("\(name) | W \(price) | \(explain)")
    }
}

class HamburgerAndSide: Menu {
    let name : String
    let price : Double
    let explain : String
    
    init(name: String, price: Double, explain: String) {
        self.name = name
        self.price = price
        self.explain = explain
    }
}

class Drinks: Menu {
    let name: String
    let price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

class Cart {
    var menus: [Menu] = []
    
    func addToMenu(_ menu: Menu) {
        menus.append(menu)
        print("\(menu.name)을(를) 장바구니에 추가했습니다.")
    }
    
    func displayCart() {
        print("[ Cart ]")
        for menu in menus {
            menu.displayInfo()
        }
        print("0. 주문 완료 | 결제하기")
        print("9. 뒤로가기  | 뒤로가기")
    }
    
    func orderSuccess() {
        print("주문이 완료되었습니다.")
        menus.removeAll()
    }
}

let cart = Cart()

let burgers: [Menu] = [
    HamburgerAndSide(name: "1. Frank Burger", price: 5.6, explain: "육즙 가득한 수제패티와 신선한 야채가 잘 어우러져 기본에 충실한 미국 동부식 오리지널 버거"),
    HamburgerAndSide(name: "2. Shrimp Burger", price: 6.0, explain: "탱탱한 새우가 들어간 새우패티를 바삭하게 튀겨 새콤달콤한 소스와 조화를 이룬 버거"),
    HamburgerAndSide(name: "3. Cheese Burger", price: 7.5, explain: "대표메뉴로서 100% 수제패티와 체다 치즈의 깊은 풍미를 이룬 시그니처 버거"),
    HamburgerAndSide(name: "4. Bacon Cheese Burger", price: 7.9, explain: "수제패티에 하와이안 스타일의 구운 파인애플과 베이컨의 조화를 이룬 스페셜 버거"),
    HamburgerAndSide(name: "5. Mushroom Burger", price: 9.3, explain: "진하게 구운 로스팅 버섯과 트러플 데리야끼 소스로 깊은 풍미의 프리미엄 머쉬룸 버거"),
    HamburgerAndSide(name: "6. JG burger", price: 9.9, explain: "구운 베이컨에 꾸덕한 치즈소스가 듬뿍 들어가 수제패티 2장과 최상의 풍미를 이룬 정통 아메리칸 버거"),
    HamburgerAndSide(name: "7. Chicken Burger", price: 6.9, explain: "겉은 바삭하고 속은 육즙가득한 닭다리살 치킨패티에 신선한 야채를 더한 오리지널 치킨 버거")
]

let sidemenus: [Menu] = [
    HamburgerAndSide(name: "1. Franch Fries", price: 2.0, explain: "크리스피 슈스티링 감자의 바삭함이 일품인 오리지널 감자튀김"),
    HamburgerAndSide(name: "2. Cheese Franch Fries", price: 3.5, explain: "바삭한 감자에 깊은 풍미의 체다치즈가 더해져 고소함을 두 배로 느낄 수 있는 감자튀김"),
    HamburgerAndSide(name: "3. Buffalo Wing", price: 5.0, explain: "뉴욕 버팔로 스타일로 겉은 바삭, 속은 촉촉하게 튀겨 짭짤한 맛이 일품인 버팔로 치킨"),
    HamburgerAndSide(name: "4. Cheese Stick", price: 2.5, explain: "쭈욱 늘어나는 고소한 모짜렐라 치즈가 가득한 인기간식"),
    HamburgerAndSide(name: "5. Cheese Ball", price: 2.5, explain: "부드러운 볼 안에 담백하고 고소한 치즈가 한 가득인 치즈볼"),
    HamburgerAndSide(name: "6. Squide Ring", price: 3.5, explain: "겉은 바삭하게 튀겨 쫄깃한 식감을 그대로 느낄 수 있는 오징어링"),
]

let drinks: [Menu] = [
    Drinks(name: "1. Ice Americano", price: 2.0),
    Drinks(name: "2. Milk Shake", price: 3.8),
    Drinks(name: "3. Pepsi", price: 2.0),
    Drinks(name: "4. Zero Pepsi", price: 2.0),
    Drinks(name: "5. Chilsung Cider", price: 2.0),
    Drinks(name: "6. Tams Zero Orange", price: 2.0),
]

func displayMenu(_ menus: [Menu], title: String) {
    print("[ \(title) ]")
    for menu in menus {
        menu.displayInfo()
    }
    print("0. 뒤로가기 | 주문을 완료하고 뒤로가기")
}

func printMainMenu() {
    print("[ FRANK BURGER ]")
    print("1. Burgers      | 직접 구워 더 솔직한 버거, 정통 미국식 프리미엄 수제 패티")
    print("2. Side Menu    | 햄버거의 풍미를 더해줄 다양한 프랭크 버거의 사이드 메뉴")
    print("3. Drinks       | 매장에서 직접 만드는 음료")
    print("4. Cart         | 현재 담겨진 메뉴를 확인하고 주문합니다.")
    print("0. 종료          | 프로그램 종료")
}

func addToCart(_ menuList: [Menu]) {
    while true {
        displayMenu(menuList, title: "MENU")
        print("원하는 메뉴의 번호를 입력하세요. 0을 입력하면 장바구니에 추가됩니다.")
        
        guard let button = readLine(), let buttonChoice = Int(button) else {
            print("입력을 확인해주세요!")
            continue
        }
            if buttonChoice == 0 {
                break
            } else if buttonChoice <= menuList.count {
                let choiceMenu = menuList[buttonChoice - 1]
                cart.addToMenu(choiceMenu)
            }
        }
    }


func getUserCredit() -> Double {
    print("현재 가지고 있는 금액을 입력하세요:")
    guard let creditButton = readLine(), let getCredit = Double(creditButton) else {
        print("입력을 확인해주세요!")
        return getUserCredit()
    }
    return getCredit
}

func calculate(in cart: Cart) -> Double {
    return cart.menus.reduce(0.0) { $0 + $1.price }
}

func paymentTime() -> Bool {
    let date = Date()
    let calender = Calendar.current
    let time = calender.component(.hour, from: date)
    
    if time >= 23 || time < 1 {
        return false
    }
    
    return true
}

func printOrderCount() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
        let menuCount = cart.menus.count
        print("현재 주문 대기수: \(menuCount)")
        printOrderCount()
    }
}

printOrderCount()

while true {
    printMainMenu()
    
    if let button = readLine() {
        if let buttonChoice = Int(button) {
            switch buttonChoice {
            case 1:
                addToCart(burgers)
            case 2:
                addToCart(sidemenus)
            case 3:
                addToCart(drinks)
            case 4:
                cart.displayCart()
                let choice = readLine() ?? ""
                    if choice == "0" {
                        let totalPrice = calculate(in: cart)
                        print("총 가격: \(totalPrice)")
                        print("현재 시간은 \(Date())입니다. 23시 ~ 01시까지는 주문 및 결제가 불가합니다.")
                        print("주문을 완료하려면 '0'을 입력하세요.")
                            if let orderChoice = readLine(), orderChoice == "0" {
                                let credit = getUserCredit()
                                if credit >= totalPrice {
                                    if paymentTime() {
                                        cart.orderSuccess()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            printMainMenu()
                                        }
                                    } else {
                                        print("현재 시간에는 결제가 불가능합니다.")
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            printMainMenu()
                                        }
                                    }
                                } else {
                                    print("현재 금액이 \(totalPrice - credit)만큼 부족해서 주문할 수 없습니다.")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        printMainMenu()
                                    }
                                }
                            }
                    }
                    else if choice == "9" {
                        break
                    }
            case 0:
                print("장비를 정지합니다.")
                exit(0)
            default:
                print("입력을 확인 해주세요!")
            }
        }
    }
}
