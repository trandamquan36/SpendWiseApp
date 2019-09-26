//
//  Item+CoreDataProperties.swift
//
//
//  Created by Quan Tran on 26/9/19.
//
//

import Foundation
import CoreData


extension Item {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var amount: String?
    @NSManaged public var date: String?
    @NSManaged public var detail: String?
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var category: String?
    @NSManaged public var user: String?
    
}
