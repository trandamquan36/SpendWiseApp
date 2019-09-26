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
    private let dataManager = CoreDataManager.shared
    
    func saveTempUsername(username:String) {
        TempData.usernameInput = username
    }

    func retrieveUsernames() -> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let usernames = userInfo.usernames
        
        return usernames
    }
   
   
}
