//
//  Contact+CoreDataProperties.swift
//  Core Data
//
//  Created by Joshua Brooks on 11/4/19.
//  Copyright © 2019 Joshua Brooks. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var first: String?
    @NSManaged public var last: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?

}
