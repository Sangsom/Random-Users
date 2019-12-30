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
    var tableView: UITableView!
    var headerView: UserDetailsHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupHeader()
        setupTableView()
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

    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        let constraints = [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension UserDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Article \(indexPath.row)"
        return cell
    }
}

extension UserDetailsViewController: UITableViewDelegate {

}
