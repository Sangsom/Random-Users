//
//  UserDetailsViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 30/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

struct Section {
    var title: String
    var fields: [String: String]
}

class UserDetailsViewController: UIViewController {

    // MARK: - Properties
    var user: Person!
    var tableView: UITableView!
    var headerView: UserDetailsHeaderView!

    var sections = [Section]()

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSectionData()

        setupHeader()
        setupTableView()
    }

    // MARK: - Custom methods

    func setupSectionData() {
        // Personal details
        var personalDetailsSection = Section(title: "Personal Details", fields: ["name": "Rinalds", "last": "Domanovs"])

        // Address
        var addressSection = Section(title: "Address", fields: ["street": "Mazcenu", "city": "Jaunmarupe"])

        // Login details

        sections.append(personalDetailsSection)
        sections.append(addressSection)
    }

    func setupHeader() {
        headerView = UserDetailsHeaderView(frame: .zero, name: user.fullName, imageURL: user.picture!)
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

// MARK: - Extensions
extension UserDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = sections[indexPath.section]
        let sectionKey = Array(sectionData.fields.keys)[indexPath.row]
        let sectionValue = Array(sectionData.fields.values)[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       // cell.textLabel?.text = sections[indexPath.section].fields[indexPath.row]
        cell.textLabel?.text = "\(sectionKey): \(sectionValue)"
        return cell
    }
}

extension UserDetailsViewController: UITableViewDelegate {

}
