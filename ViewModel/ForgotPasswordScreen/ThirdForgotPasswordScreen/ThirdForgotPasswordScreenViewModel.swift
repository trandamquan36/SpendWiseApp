//
//  ThirdForgotPasswordScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 19/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct thirdForgotPasswordScreenViewModel {
    private let dataManager = CoreDataManager.shared
    
    func retrievePasswords() -> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let passwords = userInfo.passwords
        
        return passwords
    }
    
    
    func updatePassword(username:String, password:String) {
        dataManager.updateNSUserPassword(username: username, updateInfo: password)
    }
    
    
    func retrieveTempUsername() -> String {
        return TempData.usernameInput
    }
    
    
}
