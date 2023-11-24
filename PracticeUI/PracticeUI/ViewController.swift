//
//  ViewController.swift
//  PracticeUI
//
//  Created by t2023-m0041 on 11/13/23.
//

import UIKit

class ViewController: UIViewController {
    
    let friendNames:[String] = ["kdy", "pjh", "shj"]
    let koreanName: [String: String] = ["kdy":"김동영", "pjh":"박정현", "shj":"심형준"]
    var count : Int = 0
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var bestFriendNameLable: UILabel!
    @IBOutlet weak var nextFriendNameLable: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func didTapButton(_ sender: Any) {
        nameLable.text = friendNames[0]
        bestFriendNameLable.text = friendNames[1]
        nextFriendNameLable.text = friendNames[2]
    }
}

