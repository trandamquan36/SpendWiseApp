//
//  ItemsDetailScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct ItemDetailScreenViewModel {
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: Date())
        
        return date
    }
    
    func generateID() -> UUID {
        let id = UUID()
        
        return id
    }
    
    func saveDataToCoreData(id:UUID, title:String, date:String, amount:String, itemType:String, category:String, description:String ) {
        
        let user:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataManager.persistentContainer.viewContext) as! User
        
        let item:Item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: CoreDataManager.persistentContainer.viewContext) as! Item
        
        item.id = id
        item.title = title
        item.date = date
        item.amount = amount
        item.type = itemType
        item.category = category
        item.detail = description
        
        user.addToItems(item)
        
        
        CoreDataManager.saveContext()
    }
}
