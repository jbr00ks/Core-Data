//
//  Contact+CoreDataClass.swift
//  Core Data
//
//  Created by Joshua Brooks on 11/4/19.
//  Copyright © 2019 Joshua Brooks. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {
    convenience init?(first: String?, last: String?, email: String?, phone: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Contact.entity(), insertInto: managedContext)
        
        self.first = first
        self.last = last
        self.email = email
        self.phone = phone
    }
}
