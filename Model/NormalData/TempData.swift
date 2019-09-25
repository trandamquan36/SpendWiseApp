//
//  GlobalData.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 9/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

struct TempData {
    static var nameInput:String = ""
    static var usernameInput:String = ""
    static var passwordInput:String = ""
    static var confirmPasswordInput:String = ""
    
    static var firstPinInput:String = ""
    static var secondPinInput:String = ""
    static var thirdPinInput:String = ""
    static var fourthPinInput:String = ""
    
    static var comeFromLoginScreen:Bool = false
    static var comeFromSignupScreen:Bool = false
    static var facialRecognitionAdded:Bool = false
    
    static var counter:Int = 0
    static var itemDate:String = ""
    static var itemAmount:String = ""
    static var itemType:String = CustomItemType.none.getType()
    static var expenseType:String = CustomExpenseType.none.getType()
    static var incomeType:String = CustomIncomeType.none.getType()
    static var itemDescription:String = ""
    
    static var validAmount:Bool = false
    static var editMode:Bool = false
    
    static func resetUserData() {
        nameInput = ""
        usernameInput = ""
        passwordInput = ""
        confirmPasswordInput = ""
        
        firstPinInput = ""
        secondPinInput = ""
        thirdPinInput = ""
        fourthPinInput = ""
    }
    
    static func resetItemData() {
        itemDate = ""
        itemAmount = ""
        itemDescription = ""
        itemType = CustomItemType.none.getType()
        expenseType = CustomExpenseType.none.getType()
        incomeType = CustomIncomeType.none.getType()
        
        validAmount = false
    }
}