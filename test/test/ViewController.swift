//
//  ViewController.swift
//  test
//
//  Created by t2023-m0041 on 1/4/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBAction func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func tappedButton(_ sender: Any) {
//        //present
//        //nextViecon 가져오기
//        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "nextViewController") else { return }
//        
//        // 프레젠테이션 스타일 지정
//        self.modalPresentationStyle = .fullScreen
//        
//        // 넥뷰컨 프레젠트 하기
//        self.present(nextVC, animated: true)
        
        //푸쉬 방법
        //nextViecon 가져오기
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "nextViewController") else { return }
        
        // nextViewController를 푸쉬하는 코드
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

