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

    // MARK: - Properties
    var usersController: UsersController!
    var people = [Person]()

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        usersController = UsersController()

        updateUI()
        loadUsers()
    }

    // MARK: - Custom methods

    func updateUI() {
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Random Users"

        tableView.allowsMultipleSelectionDuringEditing = true

        navigationItem.leftBarButtonItem = editButtonItem

        let shareButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(sharePerson))
        let sortButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .plain,
            target: self,
            action: #selector(openSortMenu))
        let addUserButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addUser))

        navigationItem.rightBarButtonItems = [addUserButton, sortButton, shareButton]
    }

    func loadUsers() {
        people = usersController.loadUsers()
    }

    // MARK: - Selector methods
    @objc func addUser() {
        let url = URL(string: "https://randomuser.me/api/")!

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error on loading", error)
            }

            if let data = try? JSON(data: data!) {
                DispatchQueue.main.async {
                    let addedPerson = self.usersController.addUser(from: data)

                    self.people.append(addedPerson)
                    self.tableView.reloadData()
                    self.loadUsers()
                }
            }
        }

        task.resume()
    }

    @objc func deleteRows() {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for var selectionIndex in selectedRows {
                while selectionIndex.item >= people.count {
                    selectionIndex.item -= 1
                }
                tableView(tableView, commit: .delete, forRowAt: selectionIndex)
            }
            isEditing = false
        }
    }
    @objc func openSortMenu() {
        let sortMenu = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)

        let firstNameSortAsc = UIAlertAction(title: "First Name ↑", style: .default) { _ in
            self.usersController.sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
            self.loadUsers()
            self.tableView.reloadData()
        }
        let firstNameSortDesc = UIAlertAction(title: "First Name ↓", style: .default) { _ in
            self.usersController.sortDescriptor = NSSortDescriptor(key: "firstName", ascending: false)
            self.loadUsers()
            self.tableView.reloadData()
        }
        let lastNameSortAsc = UIAlertAction(title: "Last Name ↑", style: .default) { _ in
            self.usersController.sortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
            self.loadUsers()
            self.tableView.reloadData()
        }
        let lastNameSortDesc = UIAlertAction(title: "Last Name ↓", style: .default) { _ in
            self.usersController.sortDescriptor = NSSortDescriptor(key: "lastName", ascending: false)
            self.loadUsers()
            self.tableView.reloadData()
        }
        let countrySortAsc = UIAlertAction(title: "Country ↑", style: .default) { _ in
            self.usersController.sortDescriptor = NSSortDescriptor(key: "location.country", ascending: true)
            self.loadUsers()
            self.tableView.reloadData()
        }
        let countrySortDesc = UIAlertAction(title: "Country ↓", style: .default) { _ in
            self.usersController.sortDescriptor = NSSortDescriptor(key: "location.country", ascending: false)
            self.loadUsers()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        sortMenu.addAction(firstNameSortAsc)
        sortMenu.addAction(firstNameSortDesc)
        sortMenu.addAction(lastNameSortAsc)
        sortMenu.addAction(lastNameSortDesc)
        sortMenu.addAction(countrySortAsc)
        sortMenu.addAction(countrySortDesc)
        sortMenu.addAction(cancelAction)
        present(sortMenu, animated: true)
    }

    @objc func sharePerson() {
        print("Sharing...")
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
        if !tableView.isEditing {
            if let userDetailsVC = storyboard?.instantiateViewController(withIdentifier: "UserDetails")
                as? UserDetailsViewController {
                // Pass properties
                userDetailsVC.user = people[indexPath.row]
                navigationController?.pushViewController(userDetailsVC, animated: true)
            }
        }
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = people[indexPath.row]
            PersistanceService.context.delete(commit)
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)

            PersistanceService.saveContext()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Delete",
                style: .plain,
                target: self,
                action: #selector(deleteRows))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addUser))
        }
    }
}
