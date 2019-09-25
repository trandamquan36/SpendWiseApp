//
//  EditProfileScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData
struct EditProfileScreenViewModel {
    func getNameFromCoreData() -> [String]{
        var name:[String] = []
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                name.append(result.pinNumber!)
                
            }
        } catch {
            print("Error: \(error)")
        }
        
        return name
    }
    func updateNameInCoreData(username:String, name:String) {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                
                if username == result.value(forKey: "username") as? String{
                    
                    result.setValue(name, forKey: "name")
                    break
                } else {
                }
                
            }
        } catch {
            print("Error: \(error)")
        }
        
        CoreDataManager.saveContext()
    }
    func retrieveName() -> String {
        return TempData.nameInput
    }
    func retrieveTempUsername() -> String {
        return TempData.usernameInput
    }
}
