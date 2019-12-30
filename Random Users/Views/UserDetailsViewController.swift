//
//  UserDetailsViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 30/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var user: Person!
    var headerView: UserDetailsHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupHeader()
    }

    func setupHeader() {
        headerView = UserDetailsHeaderView(frame: .zero, name: "Rinalds Domanovs")
        headerView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(headerView)

         let headerViewConstraints = [
             headerView.heightAnchor.constraint(equalToConstant: 150),
             headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ]

         NSLayoutConstraint.activate(headerViewConstraints)
    }
}
