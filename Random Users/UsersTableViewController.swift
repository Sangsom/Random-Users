//
//  UsersTableViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import CoreData
import UIKit
import SwiftyJSON

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
                let json = data["results"][0]
                print(json)

                DispatchQueue.main.async {
                    // Add to core data
                    let person = Person(context: PersistanceService.context)
                    person.gender = json["gender"].stringValue
                    
                    self.people.append(person)
                    PersistanceService.saveContext()
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
        cell.textLabel?.text = people[indexPath.row].gender
        return cell
    }
}
