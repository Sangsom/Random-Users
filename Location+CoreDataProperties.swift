//
//  Location+CoreDataProperties.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var postcode: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var streetName: String?
    @NSManaged public var streetNumber: Int16
    @NSManaged public var timezoneOffset: String?
    @NSManaged public var timezoneDescription: String?
    @NSManaged public var person: Person?

}
