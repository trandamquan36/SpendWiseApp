//
//  ThirdForgotPasswordScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 15/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class ThirdForgotPasswordScreenViewController: UIViewController {
    private let viewModel = thirdForgotPasswordScreenViewModel()
    private let validation = Validation()
    private let alert = Alert()
    
    private var validNewPassword:Bool = false
    private var validConfirmNewPassword:Bool = false
    private var username:String = ""
    private var textFields:[DesignableTextField] = []
    private var passwords:[String] = []
    
    @IBOutlet private weak var newPasswordTextField: DesignableTextField!
    
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var confirmNewPasswordLabel: UILabel!
    @IBOutlet private weak var confirmNewPasswordTextField: DesignableTextField!
    
    
    @IBAction func newPasswordDidChange(_ sender: Any) {
        guard let newPassword = newPasswordTextField.text else { return }
        guard let textAmount = newPasswordTextField.text?.count else { return }
        
        let isValidPassword:Bool = self.validation.validatePassword(password: newPassword)
        let isValidTextAmount:Bool = self.validation.validateTextAmount(
            amount: textAmount,
            minRange: 3, maxRange: 16)
        
        if newPassword.isEmpty == true {
            newPasswordLabel.text = ""
            validNewPassword = false
        } else if isValidPassword == false {
            showError(label: newPasswordLabel, text: "Password should not contain special characters", textField: newPasswordTextField)
            validNewPassword = false
        } else if isValidTextAmount == false {
            showError(label: newPasswordLabel, text: "Password should contain 3-16 characters", textField: newPasswordTextField)
            validNewPassword = false
        } else if checkSamePassword(newPassword: newPassword) == true {
            showError(label: newPasswordLabel, text: "New password can't be the same as old one", textField: newPasswordTextField)
            validNewPassword = false
        } else {
            showValid(label: newPasswordLabel, textField: newPasswordTextField)
            validNewPassword = true
        }
        
    }
    @IBAction func confirmNewPasswordDidChange(_ sender: Any) {
        guard let newPassword = newPasswordTextField.text else { return }
        guard let confirmNewPassword = confirmNewPasswordTextField.text else { return }
        
        let isSamePassword:Bool = self.validation.validateSameStrings(stringOne: newPassword, stringTwo: confirmNewPassword)
        
        if confirmNewPassword.isEmpty == true {
            confirmNewPasswordLabel.text = ""
            validConfirmNewPassword = false
        } else if isSamePassword == false {
            showError(label: confirmNewPasswordLabel, text: "Confirmed password is incorrect!", textField: confirmNewPasswordTextField)
            validConfirmNewPassword = false
        } else {
            showValid(label: confirmNewPasswordLabel, textField: confirmNewPasswordTextField)
            validConfirmNewPassword = true
        }
    }
    @IBAction func exitButton(_ sender: Any) {
        TempData.usernameInput = ""
        TempData.counter = 0
        performSegue(withIdentifier: "FP3_LoginScreen", sender: self)
    }
    @IBAction func doneButton(_ sender: Any) {
        if validNewPassword == true && validConfirmNewPassword == true {
            username = viewModel.retrieveTempUsername()
            guard let newPassword = newPasswordTextField.text else { return }
            // update password
            viewModel.updatePasswordInCoreData(username: username, password: newPassword)
            // reset all temporary data
            TempData.usernameInput = ""
            TempData.counter = 0
            // go to the next sign up screen
            performSegue(withIdentifier: "FP3_LoginScreen", sender: self)
        } else {
            alert.showIncompleteFormAlert(on: self )
            if validNewPassword == false {
                showError(label: newPasswordLabel, text: "Password cannot be empty", textField: newPasswordTextField)
            }
            if validConfirmNewPassword == false {
                showError(label: confirmNewPasswordLabel, text: "Confirmed password cannot be empty", textField: confirmNewPasswordTextField)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        populateTextFieldArray()
        UITextField.connectAllTxtFieldFields(txtfields: textFields)
    }
    

    // Overrided functions
    // Restrict user from rotating to landscape
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
    // Hide keyboard when user touches anywhere in UIViewController
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // ------------------------------------------------------------------
    
    private func showError(label: UILabel, text: String, textField: UITextField){
        textField.showError()
        label.showErrorText(text: text)
    }
    
    private func showValid(label: UILabel, textField: UITextField){
        label.text = ""
        label.textColor = Colors.getColor(redColor: 0.0, greenColor: 0.0, blueColor: 0.0, alpha: 100.0)
        textField.showNothing()
    }
    
    private func checkSamePassword(newPassword:String) -> Bool {
        passwords = viewModel.getPasswordFromCoreData()
        var isSame:Bool = false
        
        if newPassword == passwords[TempData.counter] {
            isSame = true
        } else {
            isSame = false
        }
        
        return isSame
    }
    
    private func populateTextFieldArray() {
        textFields.append(newPasswordTextField)
        textFields.append(confirmNewPasswordTextField)
    }
}
