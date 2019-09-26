//
//  User+CoreDataProperties.swift
//
//
//  Created by Quan Tran on 26/9/19.
//
//

import Foundation
import CoreData


extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var pinNumber: String?
    @NSManaged public var username: String?
    
}
