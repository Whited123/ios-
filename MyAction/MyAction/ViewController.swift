//
//  ViewController.swift
//  MyAction
//
//  Created by t2023-m0041 on 11/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MyButton:UIButton!
    @IBOutlet weak var MyLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func didTapMyButton(_ sender: Any) {
        print("안녕 난 김동영이야.")
    }
}

