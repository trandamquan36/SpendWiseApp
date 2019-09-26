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
    private let dataManager = CoreDataManager.shared
    
    func retrieveName() -> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let names = userInfo.names
        
        return names
    }
    func updateName(username:String, name:String) {
        dataManager.updateNSUserName(username: username, updateInfo: name)
    }
    func retrieveName() -> String {
        return TempData.nameInput
    }
    func retrieveTempUsername() -> String {
        return TempData.usernameInput
    }
}
