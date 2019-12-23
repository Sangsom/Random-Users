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

        let login = Login(context: PersistanceService.context)
        let uuid = UUID(uuidString: json["login"]["uuid"].stringValue)
        login.uuid = uuid
        login.username = json["login"]["username"].stringValue
        login.password = json["login"]["password"].stringValue
        login.salt = json["login"]["salt"].stringValue
        login.md5 = json["login"]["md5"].stringValue
        login.sha1 = json["login"]["sha1"].stringValue
        login.sha265 = json["login"]["sha256"].stringValue

        person.name = name
        person.login = login

        PersistanceService.saveContext()

        print("Add User", json)

        return person
    }
}
