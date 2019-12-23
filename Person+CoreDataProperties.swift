//
//  Person+CoreDataProperties.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var gender: String?
    @NSManaged public var email: String?
    @NSManaged public var name: Name
    @NSManaged public var login: Login?

    var fullName: String {
        return "\(name.first) \(name.last)"
    }
}
