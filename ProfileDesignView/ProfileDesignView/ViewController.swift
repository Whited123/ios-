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
            profileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        profileButton.backgroundColor = .systemPink
        profileButton.setTitleColor(.white, for: .normal)
        
        let profileViewButton = UIButton(type: .system)
        profileViewButton.setTitle("내 프로필 확인", for: .normal)
        profileViewButton.addTarget(self, action: #selector(openProfileView), for: .touchUpInside)
        profileViewButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileViewButton)
        
        NSLayoutConstraint.activate([
            profileViewButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            profileViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 100),
            profileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        profileViewButton.backgroundColor = .systemBlue
        profileViewButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func openProfile() {
        let profileVC = ProfileDesignViewController()
        self.present(profileVC, animated: true, completion: nil)
    }

    @objc func openProfileView() {
        let profileVC = ProfileViewController()
        profileVC.userName = "김 동영"
        profileVC.userAge = 25
        self.present(profileVC, animated: true, completion: nil)
    }
}

