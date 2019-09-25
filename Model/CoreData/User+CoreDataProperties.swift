//
//  User+CoreDataProperties.swift
//
//
//  Created by Quan Tran on 21/9/19.
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
    @NSManaged public var items: NSSet?
    
}

// MARK: Generated accessors for items
extension User {
    
    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)
    
    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)
    
    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)
    
    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)
    
}
