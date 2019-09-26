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
    private let dataManager = CoreDataManager.shared
    
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
    
  
    func retrieveUsernames() -> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let usernames = userInfo.usernames
        
        return usernames
    }
    
}
