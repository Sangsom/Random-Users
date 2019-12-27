//
//  Person+CoreDataProperties.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 27/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var cellphone: String?
    @NSManaged public var dob: Date?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var lastName: String?
    @NSManaged public var md5: String?
    @NSManaged public var nationality: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var picture: URL?
    @NSManaged public var registered: Date?
    @NSManaged public var salt: String?
    @NSManaged public var sha1: String?
    @NSManaged public var sha256: String?
    @NSManaged public var title: String?
    @NSManaged public var username: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var location: Location?

}
