//
//  Login+CoreDataProperties.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData


extension Login {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Login> {
        return NSFetchRequest<Login>(entityName: "Login")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var salt: String?
    @NSManaged public var md5: String?
    @NSManaged public var sha1: String?
    @NSManaged public var sha265: String?

}
