//
//  SecondSignupScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 19/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

struct SecondSignupScreenViewModel {
    func saveUserPinNumber(firstPin:String, secondPin:String, thirdPin:String, fourthPin:String){
        TempData.firstPinInput = firstPin
        TempData.secondPinInput = secondPin
        TempData.thirdPinInput = thirdPin
        TempData.fourthPinInput = fourthPin
    }
    
    func retrievePinNumber() -> (firstPin:String, secondPin:String, thirdPin:String, fourthPin:String){
        let firstPin = TempData.firstPinInput
        let secondPin = TempData.secondPinInput
        let thirdPin = TempData.thirdPinInput
        let fourthPin = TempData.fourthPinInput
        return (firstPin: firstPin, secondPin: secondPin, thirdPin: thirdPin, fourthPin: fourthPin)
    }
    
}
