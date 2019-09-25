//
//  SecondSignupScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 14/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class SecondSignupScreenViewController: UIViewController {
    // SecondSignupScreen variables
    private let viewModel = SecondSignupScreenViewModel()
    private let alert = Alert()
    private var textFields:[DesignableTextField] = []
    private var userPinNumber:(firstPin:String, secondPin:String, thirdPin:String, fourthPin:String)?
    // SecondSignupScreen UI Elements
    
    @IBOutlet private weak var FirstPin: DesignableTextField!
    
    @IBOutlet private weak var SecondPin: DesignableTextField!
    @IBOutlet private weak var ThirdPin: DesignableTextField!
    @IBOutlet private weak var FourthPin: DesignableTextField!
    
    @IBAction private func firstPinDidChange(_ sender: Any) {
        SecondPin.becomeFirstResponder()
    }
    @IBAction private func secondPinDidChange(_ sender: Any) {
        ThirdPin.becomeFirstResponder()
    }
    
    @IBAction private func ThirdPinDidChange(_ sender: Any) {
        FourthPin.becomeFirstResponder()
    }
   
    @IBAction private func FourthPinDidChange(_ sender: Any) {
        FourthPin.resignFirstResponder()
    }
    
    @IBAction private func cancelBarButton(_ sender: Any) {
        // If user cancel half-way through, temporary data will reset back to nothing
        TempData.resetUserData()
        TempData.facialRecognitionAdded = false
        performSegue(withIdentifier: "Signup2_LoginScreen", sender: self)
    }
    
    
    @IBAction private func backButton(_ sender: Any) {
        // if user choose go back to user information screen then save the pin number
        guard let firstPin = FirstPin.text, let secondPin = SecondPin.text,
              let thirdPin = ThirdPin.text, let fourthPin = FourthPin.text
            else { return }
        viewModel.saveUserPinNumber(firstPin: firstPin, secondPin: secondPin, thirdPin: thirdPin, fourthPin: fourthPin)
        performSegue(withIdentifier: "Signup2_Signup1", sender: self)
       
    }
    
    @IBAction private func continueButton(_ sender: Any) {
        guard let firstPin = FirstPin.text, let secondPin = SecondPin.text,
            let thirdPin = ThirdPin.text, let fourthPin = FourthPin.text
            else { return }
        
        if !firstPin.isEmpty && !secondPin.isEmpty && !thirdPin.isEmpty && !fourthPin.isEmpty {
            viewModel.saveUserPinNumber(firstPin: firstPin, secondPin: secondPin, thirdPin: thirdPin, fourthPin: fourthPin)
//            TempData.facialRecognitionAdded = true
            performSegue(withIdentifier: "Signup2_Signup3", sender: self)
        } else {
            alert.showWrongPinNumberAlert(on: self)
        }
        
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Populate array of text fields
        populateTextFieldArray()
        // Connect all of the text fields
        UITextField.connectAllTxtFieldFields(txtfields: textFields)
        // Automatically show keyboard
        if checkAllEmptyInputs() == true {
            showKeyboard()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //save users' inputs if they ever go back to the first signup screen
        updateTextFieldInputs()
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
    
    // ---------------------------------------------------------
    // Normal functions
    
    private func populateTextFieldArray(){
        textFields.append(FirstPin)
        textFields.append(SecondPin)
        textFields.append(ThirdPin)
        textFields.append(FourthPin)
    }
    
    private func showKeyboard(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.FirstPin.becomeFirstResponder()
        }
        
    }
    
    private func checkAllEmptyInputs() -> Bool {
        var isEmpty:Bool = false
        for textField in textFields {
            if textField.text!.isEmpty {
                isEmpty = true
            } else {
                isEmpty = false
                break
            }
        }
        return isEmpty
    }
    
    
    private func updateTextFieldInputs(){
        userPinNumber = viewModel.retrievePinNumber()
        FirstPin.text = userPinNumber?.firstPin
        SecondPin.text = userPinNumber?.secondPin
        ThirdPin.text = userPinNumber?.thirdPin
        FourthPin.text = userPinNumber?.fourthPin
    }
}
