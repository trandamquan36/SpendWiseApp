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
    private let dataManager = CoreDataManager.shared
    
    func retrievePassword() -> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let passwords = userInfo.passwords
        
        return passwords
    }
}
