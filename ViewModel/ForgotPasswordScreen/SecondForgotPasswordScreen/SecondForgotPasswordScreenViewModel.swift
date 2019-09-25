//
//  SecondForgotPasswordScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 19/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct SecondForgotPasswordScreenViewModel {
    
    func getPinNumberFromCoreData() -> [String]{
        var pins:[String] = []
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                pins.append(result.pinNumber!)
                
            }
        } catch {
            print("Error: \(error)")
        }
        return pins
    }
    
}
