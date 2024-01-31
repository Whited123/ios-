//
//  ViewController.swift
//  ProfileDesignView
//
//  Created by t2023-m0041 on 1/31/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let profileButton = UIButton()
        profileButton.setTitle("Profile", for: .normal)
        profileButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        view.addSubview(profileButton)
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 100),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        profileButton.backgroundColor = .blue
        profileButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func openProfile() {
        let profileVC = ProfileDesignViewController()
        self.present(profileVC, animated: true, completion: nil)
    }


}

