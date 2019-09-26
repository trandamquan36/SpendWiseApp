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
    private let dataManager = CoreDataManager.shared
    
    func retrievePinNumbers()-> [String]{
        let userInfo = dataManager.retrieveNSUsers()
        let pins = userInfo.pins
        
        return pins
    }
    
    
    func updatePinNumber(username:String, pin:String) {
        dataManager.updateNSUserPinNumber(username: username, updateInfo: pin)
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
