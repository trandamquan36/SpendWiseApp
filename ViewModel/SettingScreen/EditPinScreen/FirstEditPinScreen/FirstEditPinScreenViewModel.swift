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
    private let dataManager = CoreDataManager.shared
    
    func retrievePinNumbers() -> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let pins = userInfo.pins
        
        return pins
    }
}
