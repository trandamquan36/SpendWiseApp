//
//  EditPasswordScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData
struct FirstEditPasswordScreenViewModel {
    func getPasswordFromCoreData() -> [String]{
        var password:[String] = []
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                password.append(result.password!)
                
            }
        } catch {
            print("Error: \(error)")
        }
        
        return password
    }
}
