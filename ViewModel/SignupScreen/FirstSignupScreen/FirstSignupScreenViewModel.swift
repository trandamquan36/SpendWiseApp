//
//  FirstSignupScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 13/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct FirstSignupScreenViewModel {
    
    func saveTempUserInfo(name: String, username: String, password: String, confirmPassword: String){
        TempData.nameInput = name
        TempData.usernameInput = username
        TempData.passwordInput = password
        TempData.confirmPasswordInput = confirmPassword
    }
    
    func retrieveTempUserInfo() -> (name: String, username: String, password: String, confirmPassword: String){
        let name = TempData.nameInput
        let username = TempData.usernameInput
        let password = TempData.passwordInput
        let confirmPassword = TempData.confirmPasswordInput
        
        return (name: name, username: username, password: password, confirmPassword: confirmPassword)
    }
    
  
 
    func getUsernameFromCoreData() -> [String]{
        var usernames:[String] = []
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                usernames.append(result.username!)
                
            }
        } catch {
            print("Error: \(error)")
        }
        
        return usernames
    }
    
}
