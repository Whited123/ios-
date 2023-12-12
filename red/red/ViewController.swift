//
//  ViewController.swift
//  red
//
//  Created by t2023-m0041 on 12/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countLable: UILabel!
    var count:Int = 0
    
    @IBAction func minusButton(_ sender: Any) {
        count -= 1
        countLable.text = "\(count)"
    }
    
    @IBAction func plusButton(_ sender: Any) {
        count += 1
        countLable.text = "\(count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

