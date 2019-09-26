//
//  SecondForgotPasswordScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 19/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct SecondForgotPasswordScreenViewModel {
    private let dataManager = CoreDataManager.shared
    
    func retrievePinNumbers() -> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let pins = userInfo.pins
        
        return pins
    }
    
}
