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
        person.title = json["name"]["title"].stringValue
        person.firstName = json["name"]["first"].stringValue
        person.lastName = json["name"]["last"].stringValue
        person.email = json["email"].stringValue

        let location = Location(context: PersistanceService.context)
        location.city = json["location"]["city"].stringValue
        location.state = json["location"]["state"].stringValue
        location.country = json["location"]["country"].stringValue
        location.postcode = json["location"]["postcode"].stringValue
        location.streetName = json["location"]["street"]["name"].stringValue
        location.streetNumber = json["location"]["street"]["number"].int16Value
        location.latitude = json["location"]["coordinates"]["latitude"].stringValue
        location.longitude = json["location"]["coordinates"]["longitude"].stringValue
        location.timezoneOffset = json["location"]["timezone"]["offset"].stringValue
        location.timezoneDescription = json["location"]["timezone"]["description"].stringValue
        person.location = location

        PersistanceService.saveContext()

        print("Add User", person)

        return person
    }
}
