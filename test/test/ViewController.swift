//
//  ViewController.swift
//  test
//
//  Created by t2023-m0041 on 2/20/24.
//

import UIKit // 메인파티 UIKit, MapKit 임포트
import MapKit

// VC
class ViewController: UIViewController {
    
    // 인스턴스 초기화
    // 맵뷰 관련
    var mapView: MKMapView! // 지도
    var pinButton: UIButton! // 핀 버튼
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mapView 설정 관련
        mapView = MKMapView(frame: view.bounds) // 초기화해둔 인스턴스에 지도 설정(크기는 부모 뷰의 크기에 맞게 설정)
        // mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 부모뷰의 크기가 변경되었을때 지도의 크기도 함께 변경되는 코드
        
        // pinButton 설정 관련
        pinButton = UIButton(frame: CGRect(x: 20, y: 50, width: 100, height: 50)) // 버튼 설정. 현재는 임의 수치를 줘서 설정
        pinButton.setTitle("핀 세우기", for: .normal) // 버튼 이름 설정
        pinButton.setTitleColor(.blue, for: .normal) // 색깔 설정
        pinButton.addTarget(self, action: #selector(addPin), for: .touchUpInside) // 버튼 클릭 시 addPin함수 실행
        
        // addSubview
        view.addSubview(mapView)
        view.addSubview(pinButton)
        
        // 지도 반경 및 초기 값 설정
        mapViewSetting()
    }
    
    func mapViewSetting() {
        let startLoction = CLLocation(latitude: 37.5665, longitude: 126.9780)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: startLoction.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func addPin() {
        let centerCoordinate = mapView.centerCoordinate
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = centerCoordinate
        annotation.title = "위치 선정"
        mapView.addAnnotation(annotation)
    }
    
}

