//
//  ViewController.swift
//  countApp
//
//  Created by t2023-m0041 on 12/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    var count:Int = 0
    
    @IBAction func minusButton(_ sender: Any) {
        count -= 1
        countLabel.text = "\(count)"
    }
    
    @IBAction func plusButton(_ sender: Any) {
        count += 1
        countLabel.text = "\(count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countLabel.text = "\(count)"
    }


}

