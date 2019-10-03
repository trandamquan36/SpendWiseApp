//
//  Goal+CoreDataProperties.swift
//
//
//  Created by Quan Tran on 3/10/19.
//
//

import Foundation
import CoreData


extension Goal {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }
    
    @NSManaged public var amount: String?
    @NSManaged public var date: String?
    @NSManaged public var didBegin: Bool
    @NSManaged public var time: String?
    @NSManaged public var username: String?
    
}
