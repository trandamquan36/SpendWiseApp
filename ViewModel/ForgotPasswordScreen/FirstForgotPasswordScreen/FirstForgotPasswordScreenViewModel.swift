//
//  ForgotPasswordScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 15/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct FirstForgotPasswordScreenViewModel {
    func saveTempUsername(username:String) {
        TempData.usernameInput = username
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
