//
//  ViewController.swift
//  red
//
//  Created by t2023-m0041 on 12/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLable: UILabel!
    
    @IBAction func tappedButton(_ sender: Any) {
        self.textLable.text = "버튼을 클릭했습니다."
        let button = sender as? UIButton
        button?.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

