while true {
    print("[ FRANK BURGER ]")
    print("1. Burgers      | 직접 구워 더 솔직한 버거, 정통 미국식 프리미엄 수제 패티")
    print("2. Side Menu    | 햄버거의 풍미를 더해줄 다양한 프랭크 버거의 사이드 메뉴")
    print("3. Drinks       | 매장에서 직접 만드는 음료")
    print("0. 종료          | 프로그램 종료")
    
    if let button = readLine() {
        if let buttonChoice = Int(button) {
            switch buttonChoice {
            case 1 :
                print("[ Burgers ]")
                print("1. Frank Burger        | W 5.6 | 육즙 가득한 수제패티와 신선한 야채가 잘 어우러져 기본에 충실한 미국 동부식 오리지널 버거")
                print("2. Shrimp Burger       | W 6.0 | 탱탱한 새우가 들어간 새우패티를 바삭하게 튀겨 새콤달콤한 소스와 조화를 이룬 버거")
                print("3. Cheese Burger       | W 7.5 | 대표메뉴로서 100% 수제패티와 체다 치즈의 깊은 풍미를 이룬 시그니처 버거")
                print("4. Bacon Cheese Burger | W 7.9 | 수제패티에 하와이안 스타일의 구운 파인애플과 베이컨의 조화를 이룬 스페셜 버거")
                print("5. Mushroom Burger     | W 9.3 | 진하게 구운 로스팅 버섯과 트러플 데리야끼 소스로 깊은 풍미의 프리미엄 머쉬룸 버거")
                print("6. JG burger           | W 9.9 | 구운 베이컨에 꾸덕한 치즈소스가 듬뿍 들어가 수제패티 2장과 최상의 풍미를 이룬 정통 아메리칸 버거")
                print("7. Chicken Burger      | W 6.9 | 겉은 바삭하고 속은 육즙가득한 닭다리살 치킨패티에 신선한 야채를 더한 오리지널 치킨 버거")
                print("0. 뒤로가기              | 뒤로가기")
            case 2 :
                print("[ Side Menu ]")
                print("1. Franch Fries        | W 2.0 | 크리스피 슈스티링 감자의 바삭함이 일품인 오리지널 감자튀김")
                print("2. Cheese Franch Fries | W 3.5 | 바삭한 감자에 깊은 풍미의 체다치즈가 더해져 고소함을 두 배로 느낄 수 있는 감자튀김")
                print("3. Buffalo Wing        | W 5.0 | 뉴욕 버팔로 스타일로 겉은 바삭, 속은 촉촉하게 튀겨 짭짤한 맛이 일품인 버팔로 치킨")
                print("4. Cheese Stick        | W 2.5 | 쭈욱 늘어나는 고소한 모짜렐라 치즈가 가득한 인기간식")
                print("5. Cheese Ball         | W 2.5 | 부드러운 볼 안에 담백하고 고소한 치즈가 한 가득인 치즈볼")
                print("6. Squide Ring         | W 3.5 | 겉은 바삭하게 튀겨 쫄깃한 식감을 그대로 느낄 수 있는 오징어링")
                print("0. 뒤로가기              | 뒤로가기")
            case 3 :
                print("[ Drinks ]")
                print("1. Ice Americano     | W 2.0 |")
                print("2. Milk Shake        | W 3.8 |")
                print("3. Pepsi             | W 2.0 |")
                print("4. Zero Pepsi        | W 2.0 |")
                print("5. Chilsung Cider    | W 2.0 |")
                print("6. Tams Zero Orange  | W 2.0 |")
                print("0. 뒤로가기            | 뒤로가기")
            case 0 :
                print("장비를 정지합니다.")
                exit(0)
            default :
                print("입력을 확인 해주세요!")
            } 
            }
        }
    }

