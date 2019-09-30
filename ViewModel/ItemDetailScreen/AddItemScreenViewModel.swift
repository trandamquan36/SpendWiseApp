//
//  ItemsDetailScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct AddItemScreenViewModel {
    private let dataManager = CoreDataManager.shared
    
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
    
    func addItem(id:UUID, title:String, date:String, amount:String, type:String, category:String, description:String, user:String ) {
        
        dataManager.addNSItem(id: id, title: title, date: date, amount: amount, type: type, category: category, description: description, user: user)
    }
    
    func updateItem(id: UUID, title:String, amount:String, category:String, description:String, user:String ) {
        dataManager.updateNSItemInfo(id: id, username: user, title: title, amount: amount, category: category, description: description)
    }
}
