//
//  UserDetailsHeaderView.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 27/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class UserDetailsHeaderView: UIView {

//    lazy var profileImage: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.load(from: self.imageURL!)
//        return imageView
//    }()
    var image = UIImage()
    var nameLabel = UILabel()

    init(frame: CGRect, name: String, imageURL: URL) {
        self.nameLabel.text = name
        super.init(frame: frame)
        setupView()
        print(name, imageURL)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.backgroundColor = .red

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        let nameConstraints = [
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28)
        ]

        NSLayoutConstraint.activate(nameConstraints)

        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .green
    }
}
