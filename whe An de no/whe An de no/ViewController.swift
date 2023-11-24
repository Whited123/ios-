//
//  ViewController.swift
//  whe An de no
//
//  Created by t2023-m0041 on 11/6/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var MyButton: UIButton!
    @IBOutlet weak var helloLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func touchButton(_ sender: Any) {
        print("배경색 변카이.")
        if view.backgroundColor == .blue {
            view.backgroundColor = .yellow
        } else {
            view.backgroundColor = .blue
        }
        helloLable.text = "안녕 동영아"
    }
}

