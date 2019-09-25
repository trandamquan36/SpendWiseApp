//
//  Validation.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 12/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

struct Validation {
    func validateTextAmount(amount: Int, minRange: Int, maxRange: Int) -> Bool{
        if amount >= minRange && amount <= maxRange {
            return true
        } else {
            return false
        }
    }
   
    func validateName(name: String) -> Bool{
        var isValidName:Bool = false
        for char in name {
            if (!(char >= "a" && char <= "z") && !(char >= "A" && char <= "Z") &&
                !(char >= "0" && char <= "9")) {
                isValidName = false
                break
            }
            else {
                isValidName = true
            }
        }
        return isValidName
    }
    
    func validatePassword(password: String) -> Bool {
        var isValidPassword:Bool = false
        for char in password {
            if (!(char >= "a" && char <= "z") && !(char >= "A" && char <= "Z") &&
                !(char >= "0" && char <= "9")) {
                isValidPassword = false
                break
            }
            else {
                isValidPassword = true
            }
        }
        return isValidPassword
    }
    
    func validateSameStrings(stringOne: String, stringTwo: String) -> Bool {
        let trimmedStringOne = stringOne.trimmingCharacters(in: .whitespaces)
        let trimmedStringTwo = stringTwo.trimmingCharacters(in: .whitespaces)
        
        if trimmedStringOne == trimmedStringTwo {
            return true
        } else {
            return false
        }
    }
    
    func validateAmount(string:String) -> Bool{
        var isValidAmount:Bool = false
        if countOccurences(key: ".", string: string) > 1 {
            isValidAmount = false
        } else {
            isValidAmount = true
        }
        return isValidAmount
    }
    
    func countOccurences(key:Character, string:String) -> Int {
        var count:Int = 0
        for char in string {
            if char == key {
                count += 1
            }
        }
        return count
    }
}
