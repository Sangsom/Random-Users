//
//  UserDetailsHeaderView.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 27/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit
import FlagKit

class UserDetailsHeaderView: UIView {

    // MARK: - Properties

    weak var delegate: ChildNavigationDelegate?

    var imageView = UIImageView()
    var flagImageView = UIImageView()
    var imageURL: URL?
    var nationality: String?
    var nameLabel = UILabel()
    var mapButton = UIButton(type: .system)
    var imageSize: CGFloat = 110

    // MARK: - Required methods

    init(frame: CGRect, name: String, imageURL: URL, nationality: String) {
        self.nameLabel.text = name
        self.imageURL = imageURL
        self.nationality = nationality
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    func setupView() {
        self.backgroundColor = UIColor(hue: 88 / 360, saturation: 0.15, brightness: 1, alpha: 1)

       // setupFlagImage()
        setupImageView()
        setupNameLabel()
        setupMapButton()
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
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
    }

    func setupFlagImage() {
        guard let countryCode = nationality else { return }

        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(flagImageView)

        let constraints = [
            flagImageView.topAnchor.constraint(equalTo: topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        let flag = Flag(countryCode: countryCode)!

        flagImageView.image = flag.image(style: .square)
        flagImageView.layer.opacity = 0.33
//        flagImageView.contentMode = .scaleAspectFit

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

    func setupMapButton() {
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapButton)

        let constraints = [
            mapButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mapButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]

        NSLayoutConstraint.activate(constraints)

        mapButton.setTitle("Show on Map", for: .normal)
        mapButton.addTarget(self, action: #selector(showMap), for: .touchUpInside)
    }

    // MARK: - @Objc methods

    @objc func showMap() {
        // Open map view
        delegate?.navigateToCustomViewController()
        
        // Pass location coordinates
    }
}
