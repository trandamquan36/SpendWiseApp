//
//  SecondForgotPasswordScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 15/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class SecondForgotPasswordScreenViewController: UIViewController {
    private let viewModel = SecondForgotPasswordScreenViewModel()
    private let alert = Alert()
    private var textFields:[DesignableTextField] = []
    private var pinNumbers:[String] = []
    
    @IBOutlet private weak var firstPin: DesignableTextField!
    @IBOutlet private weak var secondPin: DesignableTextField!
    @IBOutlet private weak var thirdPin: DesignableTextField!
    @IBOutlet private weak var fourthPin: DesignableTextField!
    
  
    @IBAction private func firstPinDidChange(_ sender: Any) {
        secondPin.becomeFirstResponder()
    }
    @IBAction private func secondPinDidChange(_ sender: Any) {
        thirdPin.becomeFirstResponder()
    }
    @IBAction private func thirdPinDidChange(_ sender: Any) {
        fourthPin.becomeFirstResponder()
    }
    @IBAction private func fourthPinDidChange(_ sender: Any) {
        fourthPin.resignFirstResponder()
    }
    
    @IBAction private func exitButton(_ sender: Any) {
        TempData.usernameInput = ""
        TempData.counter = 0
        performSegue(withIdentifier: "FP2_LoginScreen", sender: self)
    }
    
    
    @IBAction func continueButton(_ sender: Any) {
        guard let firstPin = firstPin.text, let secondPin = secondPin.text,
            let thirdPin = thirdPin.text, let fourthPin = fourthPin.text
            else { return }
        
        if !firstPin.isEmpty && !secondPin.isEmpty && !thirdPin.isEmpty && !fourthPin.isEmpty {
            let pinNumber = firstPin + secondPin + thirdPin + fourthPin
            if checkIfSamePin(pin: pinNumber) == true {
                performSegue(withIdentifier: "FP2_FP3", sender: self)
            } else {
                alert.showWrongPinNumberAlert(on: self)
            }
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
    

    // Overrided functions
    // Restrict user from rotating to landscape
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
    // Hide keyboard when user touches anywhere in UIViewController
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func populateTextFieldArray(){
        textFields.append(firstPin)
        textFields.append(secondPin)
        textFields.append(thirdPin)
        textFields.append(fourthPin)
    }
    
    private func showKeyboard(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.firstPin.becomeFirstResponder()
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
    
    private func checkIfSamePin(pin:String) -> Bool{
        pinNumbers = viewModel.retrievePinNumbers()
        var isSame:Bool = false
        
        if pin == pinNumbers[TempData.counter] {
            isSame = true
        } else {
            isSame = false
        }
        
        return isSame
    }
}
