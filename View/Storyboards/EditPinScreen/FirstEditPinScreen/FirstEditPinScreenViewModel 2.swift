//
//  EditPinScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData
struct FirstEditPinScreenViewModel {
    func getPINFromCoreData() -> [String]{
        var pin:[String] = []
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                pin.append(result.pinNumber!)
                
            }
        } catch {
            print("Error: \(error)")
        }
        
        return pin
    }
}
