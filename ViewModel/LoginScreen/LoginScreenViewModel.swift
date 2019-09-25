//
//  LoginScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 15/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct LoginScreenViewModel {
    func getDataFromCoreData() ->(names:[String], usernames:[String], passwords:[String], pins:[String]){
        var names:[String] = []
        var usernames:[String] = []
        var passwords:[String] = []
        var pins:[String] = []
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                names.append(result.name!)
                usernames.append(result.username!)
                passwords.append(result.password!)
                pins.append(result.pinNumber!)
                print(result.username!)
            }
        } catch {
            print("Error: \(error)")
        }
        
        return (names: names, usernames: usernames, passwords: passwords, pins: pins)
    }
    
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
    
    
    // create a dummy account for UITest
    func createDummyUserCoreData(name:String, username:String, password:String, pinNumber:String ) {
        let user:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataManager.persistentContainer.viewContext) as! User
        
        user.name = name
        user.username = username
        user.password = password
        user.pinNumber = pinNumber
        
        CoreDataManager.saveContext()
    }
    
    func createDummyItemCoreData(id:UUID, date:String, amount:String, type:String, expenseType:String, incomeType:String, description:String) {
      
        
        let item:Item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: CoreDataManager.persistentContainer.viewContext) as! Item
        
        item.id = id
        item.date = date
        item.amount = amount
        item.type = type
        item.expenseType = expenseType
        item.incomeType = incomeType
        item.detail = description
        
        CoreDataManager.saveContext()
    }
}
