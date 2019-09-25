//
//  SecondEditPinScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 22/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct SecondEditPinScreenViewModel {
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
    func updatePinNumbersInCoreData(username:String, pin:String) {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [User] {
                
                if username == result.value(forKey: "username") as? String{
                    
                    result.setValue(pin, forKey: "pin")
                    break
                } else {
                }
                
            }
        } catch {
            print("Error: \(error)")
        }
        
        CoreDataManager.saveContext()
    }
    func retrievePinNumber() -> (firstPin:String, secondPin:String, thirdPin:String, fourthPin:String){
        let firstPin = TempData.firstPinInput
        let secondPin = TempData.secondPinInput
        let thirdPin = TempData.thirdPinInput
        let fourthPin = TempData.fourthPinInput
        return (firstPin: firstPin, secondPin: secondPin, thirdPin: thirdPin, fourthPin: fourthPin)
    }
    func retrieveTempUsername() -> String {
        return TempData.usernameInput
    }
}
