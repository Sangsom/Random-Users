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
import Contacts

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

        person.uuid = UUID(uuidString: json["login"]["uuid"].stringValue)
        person.gender = json["gender"].stringValue
        person.title = json["name"]["title"].stringValue
        person.firstName = json["name"]["first"].stringValue
        person.lastName = json["name"]["last"].stringValue
        person.email = json["email"].stringValue
        person.username = json["login"]["username"].stringValue
        person.password =  json["login"]["password"].stringValue
        person.salt = json["login"]["salt"].stringValue
        person.md5 = json["login"]["md5"].stringValue
        person.sha1 = json["login"]["sha1"].stringValue
        person.sha256 = json["login"]["sha256"].stringValue
        person.nationality = json["nat"].stringValue

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

        let dob = json["dob"]["date"].stringValue
        let dobDate = dateFormatter.date(from: dob)
        person.dob = dobDate

        let registered = json["registered"]["date"].stringValue
        let registeredDate = dateFormatter.date(from: registered)
        person.registered = registeredDate

        person.phone = json["phone"].stringValue
        person.cellphone = json["cell"].stringValue

        let pictureURL = URL(string: json["picture"]["large"].stringValue)
        person.picture = pictureURL

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

    func saveToContacts(user: Person) -> Bool {
        print(user)
        let contact = CNMutableContact()

        if let url = user.picture,
            let data = try? Data(contentsOf: url) {
            contact.imageData = data
        }

        contact.givenName = user.firstName!
        contact.familyName = user.lastName!

        let homeEmail = CNLabeledValue(label: CNLabelHome, value: user.email! as NSString)
        contact.emailAddresses = [homeEmail]

        contact.phoneNumbers = [
            CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: user.cellphone!)),
            CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: user.phone!))
        ]

        let homeAddress = CNMutablePostalAddress()
        homeAddress.street = "\(user.location!.streetNumber), \(user.location!.streetName!)"
        homeAddress.city = user.location!.city!
        homeAddress.state = user.location!.state!
        homeAddress.country = user.location!.country!
        homeAddress.postalCode = user.location!.postcode!
        contact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAddress)]

        if let date = user.dob {
            let calendar = Calendar.current
            contact.birthday = calendar.dateComponents([.year, .month, .day], from: date)
        }

        // Save contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        //try! store.execute(saveRequest)

        do {
            try store.execute(saveRequest)
            return true
        } catch {
            return false
        }
    }
}
