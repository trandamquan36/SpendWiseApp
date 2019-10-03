//
//  Alert.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 14/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    private func showBasicAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    func createAlert(vc: UIViewController, title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        return alert
    }
    
    
    func showIncompleteFormAlert(on vc: UIViewController){
        showBasicAlert(vc: vc, title: "Invalid Form", message: "Please fill out all the fields correctly")
    }
    
    func showWrongPinNumberAlert(on vc:UIViewController){
        showBasicAlert(vc: vc, title: "Invalid Pin Number", message:"Please enter again")
    }
    
    func showNoFacialRecognitionAlert(on vc:UIViewController){
        showBasicAlert(vc: vc, title:" No Facial Recognition", message: "Please add facial recognition first")
    }
    
    func showInvalidUsernameAlert(on vc:UIViewController){
        showBasicAlert(vc: vc, title: "Invalid Username", message: "The username you just entered either wrong or doesn't exist")
    }
    
    func showMissingUsernameAlert(on vc:UIViewController){
        showBasicAlert(vc: vc, title: "Missing Username", message: "Please enter a username to check")
    }
    
    func showInvalidPasswordAlert(on vc:UIViewController){
        showBasicAlert(vc: vc, title: "Invalid Password", message: "The password you just entered is wrong")
    }
    
    func showMissingLoginCredentialsAlert(on vc:UIViewController){
        showBasicAlert(vc: vc, title: "Missing credentials", message: "Please type in both username and password")
    }
    
    func showInvalidAddItemAlert(on vc:UIViewController) {
        showBasicAlert(vc: vc, title: "Add Item Failed", message: "Please fill out the fields correctly and add a category")
    }
    
    func showInvalidNumberAlert(on vc:UIViewController){
        showBasicAlert(vc: vc, title: "Invalid Numbers", message: "The amount of money you just entered is wrong")
    }
}
