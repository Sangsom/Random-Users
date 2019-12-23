//
//  UsersController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import CoreData
import Foundation

class UsersController {

    func loadUsers() -> [Person] {
        var usersList = [Person]()

        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()

        do {
            let people = try PersistanceService.context.fetch(fetchRequest)
            usersList = people
        } catch {
            print("Error")
        }

        return usersList
    }

}
