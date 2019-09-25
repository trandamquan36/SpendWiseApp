//
//  ThirdForgotPasswordScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 19/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct thirdForgotPasswordScreenViewModel {
    func getPasswordFromCoreData() -> [String]{
        var passwords:[String] = []
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                passwords.append(result.password!)
                
            }
        } catch {
            print("Error: \(error)")
        }
        return passwords
    }
    
    
    func updatePasswordInCoreData(username:String, password:String) {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                
                if username == result.value(forKey: "username") as? String{
                    
                    result.setValue(password, forKey: "password")
                    break
                } else {
                }
                
            }
        } catch {
            print("Error: \(error)")
        }
        
        CoreDataManager.saveContext()
    }
    
    
    func retrieveTempUsername() -> String {
        return TempData.usernameInput
    }
    
    
}
