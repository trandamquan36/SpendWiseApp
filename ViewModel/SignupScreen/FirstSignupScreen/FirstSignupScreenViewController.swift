//
//  FirstSignupScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 13/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class FirstSignupScreenViewController: UIViewController, UITextFieldDelegate  {
    //FirstSignUpScreen variables
    private let viewModel = FirstSignupScreenViewModel()
    private let validation = Validation()
    private let alert = Alert()
    
    private var validName:Bool = false
    private var validUsername:Bool = false
    private var validPassword:Bool = false
    private var validConfirmPassword:Bool = false
    private var usernamesInDatabase:[String] = []
    private var textFields:[DesignableTextField] = []
    private var tempInfo:(name: String, username: String, password: String, confirmPassword: String)?
    
    //FirstSignUpScreen UI Elements
    @IBOutlet private weak var nameTextField: DesignableTextField!
    @IBOutlet private weak var usernameTextField: DesignableTextField!
    @IBOutlet private weak var passwordTextField: DesignableTextField!
    @IBOutlet private weak var confirmPasswordTextField: DesignableTextField!
   
    @IBAction private func nameDidChange(_ sender: DesignableTextField) {
        guard let name = nameTextField.text else { return }
        guard let textAmount = nameTextField.text?.count else { return }
        
        let isValidName:Bool = self.validation.validateName(name: name)
        let isValidTextAmount:Bool = self.validation.validateTextAmount(
            amount: textAmount,
            minRange: 3, maxRange: 20)
        
       
        if name.isEmpty == true {
            nameLabel.text = ""
            validName = false
        } else if isValidName == false {
            showError(label: nameLabel, text: "Name should not contain special characters", textField: nameTextField)
            validName = false
        } else if isValidTextAmount == false {
            showError(label: nameLabel, text: "Name should contain 3-20 characters", textField: nameTextField)
            validName = false
        } else {
            showValid(label: nameLabel, textField: nameTextField)
            validName = true
        }
        
    }
    
    @IBAction private func usernameDidChange(_ sender: DesignableTextField) {
        guard let username = usernameTextField.text else { return }
        guard let textAmount = usernameTextField.text?.count else { return }
        
        let isValidName:Bool = self.validation.validateName(name: username)
        let isValidTextAmount:Bool = self.validation.validateTextAmount(
            amount: textAmount,
            minRange: 3, maxRange: 16)
        
        if username.isEmpty == true {
             usernameLabel.text = ""
             validUsername = false
        } else if isValidName == false {
            showError(label: usernameLabel, text: "Username should not contain special characters", textField: usernameTextField)
             validUsername = false
        } else if isValidTextAmount == false {
            showError(label: usernameLabel, text: "Username should contain 3-16 characters", textField: usernameTextField)
             validUsername = false
        } else if checkIfUsernameExists(username: username) == true {
            showError(label: usernameLabel, text: "This username already exists!", textField: usernameTextField)
        } else {
            showValid(label: usernameLabel, textField: usernameTextField)
            validUsername = true
        }
    }
    @IBAction private func passwordDidChange(_ sender: DesignableTextField) {
        guard let password = passwordTextField.text else { return }
        guard let textAmount = passwordTextField.text?.count else { return }
        
        let isValidPassword:Bool = self.validation.validatePassword(password: password)
        let isValidTextAmount:Bool = self.validation.validateTextAmount(
            amount: textAmount,
            minRange: 3, maxRange: 16)
    
        if password.isEmpty == true {
             passwordLabel.text = ""
             validPassword = false
        } else if isValidPassword == false {
            showError(label: passwordLabel, text: "Password should not contain special characters", textField: passwordTextField)
             validPassword = false
        } else if isValidTextAmount == false {
            showError(label: passwordLabel, text: "Password should contain 3-16 characters", textField: passwordTextField)
             validPassword = false
        } else {
            showValid(label: passwordLabel, textField: passwordTextField)
            validPassword = true
        }
    }
    
    @IBAction private func confirmPasswordDidChange(_ sender: DesignableTextField) {
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        let isSamePassword:Bool = self.validation.validateSameStrings(stringOne: password, stringTwo: confirmPassword)
        
        if confirmPassword.isEmpty == true {
            confirmPasswordLabel.text = ""
            validConfirmPassword = false
        } else if isSamePassword == false {
            showError(label: confirmPasswordLabel, text: "Confirmed password is incorrect!", textField: confirmPasswordTextField)
            validConfirmPassword = false
        } else {
            showValid(label: confirmPasswordLabel, textField: confirmPasswordTextField)
            validConfirmPassword = true
        }
    }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
   
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var confirmPasswordLabel: UILabel!
    
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction private func continueButtonPressed(_ sender: UIButton) {
        guard let name = nameTextField.text,
            let username = usernameTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text
            else { return }
        
        
        print("ValidName: \(validName)")
        print("ValidUsername: \(validUsername)")
        print("ValidPassword: \(validPassword)")
        print("ValidConfirmPassword: \(validConfirmPassword)")
        
        
        if validName == true && validUsername == true && validPassword == true && validConfirmPassword == true {
         
            // save temporary data
            viewModel.saveTempUserInfo(name: name, username: username, password: password, confirmPassword: confirmPassword)
            // go to the next sign up screen
            performSegue(withIdentifier: "Signup1_Signup2", sender: self)
        } else {
            alert.showIncompleteFormAlert(on: self )
            if name.isEmpty == true{
                showError(label: nameLabel, text: "Name cannot be empty", textField: nameTextField)
            }
            if username.isEmpty == true {
                showError(label: usernameLabel, text: "Username cannot be empty", textField: usernameTextField)
            }
            if password.isEmpty == true {
                showError(label: passwordLabel, text: "Password cannot be empty", textField: passwordTextField)
            }
            if confirmPassword.isEmpty == true {
                showError(label: confirmPasswordLabel, text: "Confirmed password cannot be empty", textField: confirmPasswordTextField)
            }
            
        }
    }
    
    
    @IBAction private func cancelBarButton(_ sender: Any) {
        // If user cancel half-way through, temporary data will reset back to nothing
        TempData.resetUserData()
        TempData.facialRecognitionAdded = false
        performSegue(withIdentifier: "Signup1_LoginScreen", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Populate the array with text fields
        populateTextFieldArray()
        // Connect all of the text fields
        UITextField.connectAllTxtFieldFields(txtfields: textFields)
        // Check if all inputs are valid
        

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //save users' inputs if they ever go back to the first signup screen
        updateTextFieldInputs()
        // check inputs' validity
        checkValidInputs()
    }
    


    // ---------------------------------------------------------
    // Overrided functions
    // Restrict user from rotating to landscape
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Hide keyboard when user touches anywhere in UIViewController
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
   
    // ----------------------------------------------------------
    // Normal functions
    private func populateTextFieldArray(){
        textFields.append(nameTextField)
        textFields.append(usernameTextField)
        textFields.append(passwordTextField)
        textFields.append(confirmPasswordTextField)
    }
    
    private func showError(label: UILabel, text: String, textField: UITextField){
        textField.showError()
        label.showErrorText(text: text)
    }
    
    private func showValid(label: UILabel, textField: UITextField){
        label.text = ""
        label.textColor = Colors.getColor(redColor: 0.0, greenColor: 0.0, blueColor: 0.0, alpha: 100.0)
        textField.showNothing()
    }
    
    private func updateTextFieldInputs(){
        tempInfo = viewModel.retrieveTempUserInfo()
        guard let name = tempInfo?.name, let username = tempInfo?.username,
              let password = tempInfo?.password, let confirmPassword = tempInfo?.password
            else { return }
        nameTextField.text = name
        usernameTextField.text = username
        passwordTextField.text = password
        confirmPasswordTextField.text = confirmPassword
        
    }
    
    private func checkValidInputs() {
        guard let name = nameTextField.text, let username = usernameTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        
        if name.isEmpty == true {
            validName = false
        } else {validName = true}
        
        if username.isEmpty == true {
            validUsername = false
        } else {validUsername = true}
        
        if password.isEmpty == true {
            validPassword = false
        } else {validPassword = true}
        
        if confirmPassword.isEmpty == true {
            validConfirmPassword = false
        } else {validConfirmPassword = true}
        
    }
   
    private func checkIfUsernameExists(username:String) -> Bool {
        var isExist:Bool = false
        usernamesInDatabase = viewModel.retrieveUsernames()
        
        for usernameInDatabase in usernamesInDatabase {
            if username == usernameInDatabase {
                isExist = true
                break
            } else {
                isExist = false
            }
        }
        return isExist
    }
  
}
