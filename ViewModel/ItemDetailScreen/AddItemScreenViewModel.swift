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
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm:ss"
        
        let time = formatter.string(from: Date())
        
        return time
    }
    
    func generateID() -> UUID {
        let id = UUID()
        
        return id
    }
    
    func addItem(id:UUID, title:String, date:String, time: String, amount:String, type:String, category:String, description:String, user:String ) {
        
        dataManager.addNSItem(id: id, title: title, date: date, time: time, amount: amount, type: type, category: category, description: description, user: user)
    }
    
   
}
