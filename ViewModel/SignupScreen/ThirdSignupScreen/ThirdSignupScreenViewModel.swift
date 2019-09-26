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
    private let dataManager = CoreDataManager.shared
    
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
    
    func addUser(name:String, username:String, password:String, pinNumber:String ) {
        dataManager.addNSUser(name: name, username: username, password: password, pinNumber: pinNumber)
    }
}
