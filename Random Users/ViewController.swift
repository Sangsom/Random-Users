//
//  ViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 19/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import CoreData
import UIKit

class ViewController: UIViewController {

//    var people = [Person]()

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

//        let person = Person(context: PersistanceService.context)
//        person.gender = "male"
//
//        PersistanceService.saveContext()
//
//
//        // Read
//        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
//
//        do {
//            let people = try PersistanceService.context.fetch(fetchRequest)
//
//            print(people.count)
//        } catch {
//
//        }

        updateUI()
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

    // MARK: - Selector methods
    @objc func addUser() {
        print("Adding")
    }
}

