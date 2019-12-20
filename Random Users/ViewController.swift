//
//  ViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 19/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import CoreData
import UIKit
import SwiftyJSON

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
        let url = URL(string: "https://randomuser.me/api/")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error on loading", error)
            }

            if let data = data,
                let string = String(data: data, encoding: .utf8) {
                print(string)
            }

        }

        task.resume()
    }

//    @objc func fetchCommits() {
//        let newestCommitDate = getNewestCommitDate()
//
//        if let data = try? String(contentsOf: URL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100&since=\(newestCommitDate)")!) {
//            // give the data to SwiftyJSON to parse
//            let jsonCommits = JSON(parseJSON: data)
//
//            // read the commits back out
//            let jsonCommitArray = jsonCommits.arrayValue
//
//            print("Received \(jsonCommitArray.count) new commits.")
//
//            DispatchQueue.main.async { [unowned self] in
//                for jsonCommit in jsonCommitArray {
//
//                    let commit = Commit(context: self.container.viewContext)
//                    self.configure(commit: commit, usingJSON: jsonCommit)
//
//                }
//
//                self.saveContext()
//                self.loadSavedData()
//            }
//        }
//    }
}

