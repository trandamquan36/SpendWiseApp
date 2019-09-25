//
//  ThirdSignupScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 19/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct ThirdSignupScreenViewModel {
    func retrieveTempUserInfo() -> (name: String, username: String, password: String, confirmPassword: String){
        let name = TempData.nameInput
        let username = TempData.usernameInput
        let password = TempData.passwordInput
        let confirmPassword = TempData.confirmPasswordInput
        
        return (name: name, username: username, password: password, confirmPassword: confirmPassword)
    }
    
    func retrievePinNumber() -> (firstPin:String, secondPin:String, thirdPin:String, fourthPin:String){
        let firstPin = TempData.firstPinInput
        let secondPin = TempData.secondPinInput
        let thirdPin = TempData.thirdPinInput
        let fourthPin = TempData.fourthPinInput
        return (firstPin: firstPin, secondPin: secondPin, thirdPin: thirdPin, fourthPin: fourthPin)
    }
    
    func saveUserInfoIntoCoreData(name:String, username:String, password:String, pinNumber:String ) {
        let user:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: CoreDataManager.persistentContainer.viewContext) as! User
        
        user.name = name
        user.username = username
        user.password = password
        user.pinNumber = pinNumber
        
        CoreDataManager.saveContext()
    }
}
