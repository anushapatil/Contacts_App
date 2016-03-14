//
//  Contacts+CoreDataProperties.swift
//  Contacts
//
//  Created by Anusha Patil on 12/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contacts {

    @NSManaged var namePrefix: String?
    @NSManaged var firstName: String?
    @NSManaged var middleName: String?
    @NSManaged var surname: String?
    @NSManaged var nameSuffix: String?
    @NSManaged var company: String?
    @NSManaged var title: String?
    @NSManaged var phone: String?
    @NSManaged var email: String?
    @NSManaged var address: String?
    @NSManaged var date: String?
    @NSManaged var groupName: String?
    @NSManaged var phoneType: String?
    @NSManaged var emailType: String?
    @NSManaged var addressType: String?
    @NSManaged var specialDatesType: String?

}
