//
//  UsersController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import CoreData
import Foundation
import SwiftyJSON

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

    func addUser(from json: JSON) -> Person {
        let person = Person(context: PersistanceService.context)

        let json = json["results"][0]

        person.gender = json["gender"].stringValue

        let name = Name(context: PersistanceService.context)
        name.title = json["name"]["title"].stringValue
        name.first = json["name"]["first"].stringValue
        name.last = json["name"]["last"].stringValue

        person.name = name

        PersistanceService.saveContext()

        print("Add User", json)

        return person
    }
}
