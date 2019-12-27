//
//  Person+CoreDataClass.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 27/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    var fullName: String {
        return "Rino \(firstName!) \(lastName!)"
    }
}
