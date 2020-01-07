//
//  UserDetailsViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 30/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

// MARK: - Models
struct Section {
    var title: String
    var fields: [UserData]
}

struct UserData {
    var type: String
    var value: String
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
        navigationItem.largeTitleDisplayMode = .never

        setupSectionData()

        setupHeader()
        setupTableView()
    }

    // MARK: - Custom methods

    func setupSectionData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"

        // Personal details
        let personalDetailsFields = [
            UserData(type: "gender", value: user.gender!),
            UserData(type: "nationality", value: user.nationality!),
            UserData(type: "phone", value: user.phone!),
            UserData(type: "cell", value: user.cellphone!),
            UserData(type: "birthday", value: dateFormatter.string(from: user.dob!)),
        ]
        let personalDetailsSection = Section(title: "Personal Details", fields: personalDetailsFields)

        // Address
        let addressFields = [
            UserData(type: "street", value: "\(user.location!.streetName!), \(user.location!.streetNumber)"),
            UserData(type: "city", value: user!.location!.city!),
            UserData(type: "state", value: user.location?.state ?? "N/A"),
            UserData(type: "country", value: user.location!.country!),
            UserData(type: "postcode", value: user.location!.postcode!)
        ]
        let addressSection = Section(title: "Address Details", fields: addressFields)

        // Login details
        let loginFields = [
            UserData(type: "email", value: user.email!),
            UserData(type: "username", value: " \(user.username!)"),
            UserData(type: "registered", value: dateFormatter.string(from: user.registered!))
        ]
        let loginSection = Section(title: "Login Details", fields: loginFields)

        sections.append(personalDetailsSection)
        sections.append(addressSection)
        sections.append(loginSection)
    }

    func setupHeader() {
        headerView = UserDetailsHeaderView(frame: .zero, name: user.fullName, imageURL: user.picture!, nationality: user.nationality!)
        headerView.delegate = self
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
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let vw = UIView()
//        vw.backgroundColor = .systemGray
//
//        let vwConstraints = [
//            vw.heightAnchor.constraint(equalToConstant: 40)
//        ]
//
//        NSLayoutConstraint.activate(vwConstraints)
//
//        let hStack = UIStackView()
//        hStack.axis = .horizontal
//        hStack.translatesAutoresizingMaskIntoConstraints = false
//        vw.addSubview(hStack)
//
//        let stackConstraints = [
//            hStack.topAnchor.constraint(equalTo: vw.topAnchor),
//            hStack.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
//            hStack.trailingAnchor.constraint(equalTo: vw.trailingAnchor),
//            hStack.bottomAnchor.constraint(equalTo: vw.bottomAnchor)
//        ]
//
//        NSLayoutConstraint.activate(stackConstraints)
//
//        hStack.alignment = .center
//        hStack.distribution = .fillProportionally
//
//        let image = UIImage(systemName: "person")
//        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFit
//        hStack.addArrangedSubview(imageView)
//
//        let title = UILabel()
//        title.text = sections[section].title
//        hStack.addArrangedSubview(title)
//
//        title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15).isActive = true
//
//        return vw
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = sections[indexPath.section]
        let dataType = sectionData.fields[indexPath.row].type
        let dataValue = sectionData.fields[indexPath.row].value

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(dataType.capitalized): \(dataValue)"
        return cell
    }
}

extension UserDetailsViewController: UITableViewDelegate {

}

extension UserDetailsViewController: ChildNavigationDelegate {
    func navigateToCustomViewController() {
        let vc = UserLocationViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.name = user.fullName
        vc.longitude = user.location?.longitude
        vc.latitude = user.location?.latitude
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Protocols
protocol ChildNavigationDelegate: class {
    func navigateToCustomViewController()
}
