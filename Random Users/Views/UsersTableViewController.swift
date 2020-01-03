//
//  UsersTableViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit
import SwiftyJSON
import FlagKit

class UsersTableViewController: UITableViewController {

    var usersController: UsersController!
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        usersController = UsersController()

        updateUI()
        loadUsers()
    }

    // MARK: - Custom methods

    func updateUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Random Users"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addUser))
    }

    func loadUsers() {
        people = usersController.loadUsers()
    }

    // MARK: - Selector methods
    @objc func addUser() {
        let url = URL(string: "https://randomuser.me/api/")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error on loading", error)
            }

            if let data = try? JSON(data: data!) {
                DispatchQueue.main.async {
                    let addedPerson = self.usersController.addUser(from: data)
                    self.people.append(addedPerson)
                    self.tableView.reloadData()
                }
            }
        }

        task.resume()

    }
}

extension UsersTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath)
        cell.textLabel?.text = people[indexPath.row].fullName

        if let country = people[indexPath.row].location?.country,
            let city = people[indexPath.row].location?.city {
            cell.detailTextLabel?.text = "\(country), \(city)"
        } else {
            cell.detailTextLabel?.text = "N\\A"
        }

        let countryCode = people[indexPath.row].nationality!
        let flag = Flag(countryCode: countryCode)!
        cell.imageView?.image = flag.image(style: .roundedRect)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetails") as? UserDetailsViewController {
            // Pass properties
            vc.user = people[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
