//
//  Person+CoreDataClass.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 23/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    var fullName: String {
        if let firstName = firstName, let lastName = lastName {
            return "\(firstName) \(lastName)"
        }
        return "N\\A"
    }
}
