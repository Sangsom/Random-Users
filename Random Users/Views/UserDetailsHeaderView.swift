//
//  UserDetailsHeaderView.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 27/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class UserDetailsHeaderView: UIView {

    // MARK: - Properties

    var imageView = UIImageView()
    var imageURL: URL?
    var nameLabel = UILabel()
    var imageSize: CGFloat = 110

    // MARK: - Required methods

    init(frame: CGRect, name: String, imageURL: URL) {
        self.nameLabel.text = name
        self.imageURL = imageURL
        super.init(frame: frame)
        setupView()
        print(name, imageURL)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    func setupView() {
        self.backgroundColor = .red

        setupImageView()
        setupNameLabel()
    }

    func setupImageView() {
        guard let imageURL = imageURL else { return }

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        let constraints = [
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ]

        NSLayoutConstraint.activate(constraints)

        imageView.load(from: imageURL)
        imageView.contentMode = .scaleAspectFit

        imageView.makeRoundCorners(byRadius: imageSize / 2)
        print(imageView.constraints)
    }

    func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        let nameConstraints = [
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)
        ]

        NSLayoutConstraint.activate(nameConstraints)

        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .green
    }
}
