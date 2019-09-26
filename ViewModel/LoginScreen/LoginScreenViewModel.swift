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
    private let dataManager = CoreDataManager.shared
    
    func retrieveUserInfo() -> (usernames:[String], passwords:[String]) {
        
        let userInfo = dataManager.retrieveNSUsers()
        
        let usernames = userInfo.usernames
        let passwords = userInfo.passwords
        
        return (usernames: usernames, passwords: passwords)
    }
    
    func addUser(name:String, username:String, password:String, pinNumber:String) {
        dataManager.addNSUser(name: name, username: username, password: password, pinNumber: pinNumber)
    }
    
    func addItem(id:UUID, title:String, date:String, amount:String, type:String,  category:String, description:String, user:String) {
        dataManager.addNSItem(id: id, title: title, date: date,
                              amount: amount, type: type,
                              category: category, description: description,
                              user: user)
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
   
}
