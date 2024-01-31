//
//  ProfileDesignViewController.swift
//  ProfileDesignView
//
//  Created by t2023-m0041 on 1/31/24.
//

import Foundation
import UIKit

class ProfileDesignViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "spartan")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nabeacamp"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "르탄이"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "IOS Developer"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.text = "7\npost"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followerLabel: UILabel = {
        let label = UILabel()
        label.text = "0\nfollower"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "0\nfollowing"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomLine: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let personIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            menuButton.widthAnchor.constraint(equalToConstant: 30),
            menuButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(bioLabel)
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [postLabel, followerLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -60),
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20)
        ])
        
        let followButton = UIButton(type: .system)
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.backgroundColor = UIColor.systemBlue
        followButton.layer.cornerRadius = 5
        followButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followButton)
        NSLayoutConstraint.activate([
            followButton.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 20),
            followButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -105),
            followButton.widthAnchor.constraint(equalToConstant: 150),
            followButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        let messageButton = UIButton(type: .system)
        messageButton.setTitle("Message", for: .normal)
        messageButton.setTitleColor(.black, for: .normal)
        messageButton.backgroundColor = .white
        messageButton.layer.cornerRadius = 5
        messageButton.layer.borderColor = UIColor.gray.cgColor
        messageButton.layer.borderWidth = 1
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageButton)
        NSLayoutConstraint.activate([
            messageButton.topAnchor.constraint(equalTo: followButton.topAnchor),
            messageButton.leadingAnchor.constraint(equalTo: followButton.trailingAnchor, constant: 10),
            messageButton.widthAnchor.constraint(equalToConstant: 150),
            messageButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        let moreButton = UIButton(type: .system)
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moreButton)
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: followButton.topAnchor),
            moreButton.leadingAnchor.constraint(equalTo: messageButton.trailingAnchor, constant: 15),
            moreButton.widthAnchor.constraint(equalToConstant: 30),
            moreButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let lineView = UIView()
        lineView.backgroundColor = .gray.withAlphaComponent(0.4)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 15),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let postIconView = UIImageView(image: UIImage(named: "qwe"))
        postIconView.contentMode = .scaleAspectFit
        postIconView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postIconView)
        NSLayoutConstraint.activate([
            postIconView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: 45),
            postIconView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, constant: 40),
            postIconView.widthAnchor.constraint(equalToConstant: 30),
            postIconView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: postIconView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        view.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -42),
            bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        view.addSubview(personIconImageView)
        NSLayoutConstraint.activate([
            personIconImageView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 400),
            personIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personIconImageView.widthAnchor.constraint(equalToConstant: 40),
            personIconImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let imageName = "\(indexPath.item + 1)"
        imageView.image = UIImage(named: imageName)
        
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 4 * 10) / 3
        return CGSize(width: width + 10, height: width)
    }
}
