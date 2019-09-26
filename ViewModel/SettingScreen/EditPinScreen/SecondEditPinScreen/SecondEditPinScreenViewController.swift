//
//  SecondEditPinViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 22/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class SecondEditPinViewController: UIViewController {
    private var alert = Alert()
    private var viewModel = SecondEditPinScreenViewModel()
    private var textFields:[DesignableTextField] = []
    
    
    @IBOutlet weak var firstPin: DesignableTextField!
    
    @IBOutlet weak var secondPin: DesignableTextField!
    
    @IBOutlet weak var thirdPin: DesignableTextField!
    
    @IBOutlet weak var fourthPin: DesignableTextField!
    
    
    @IBAction func firstPinDidChange(_ sender: DesignableTextField) {
        secondPin.becomeFirstResponder()
    }
    
    
    @IBAction func secondPinDidChange(_ sender: DesignableTextField) {
        thirdPin.becomeFirstResponder()
    }
    
    
    @IBAction func thirdPinDidChange(_ sender: DesignableTextField) {
        fourthPin.becomeFirstResponder()
    }
    
    
    @IBAction func fourthPinDidChange(_ sender: DesignableTextField) {
        fourthPin.resignFirstResponder()
    }
    
    @IBAction func doneBtn(_ sender: DesignableButton) {
        guard let firstPIN = firstPin.text, let secondPIN = secondPin.text,
            let thirdPIN = thirdPin.text, let fourthPIN = fourthPin.text
            else { return }
        
        if !firstPIN.isEmpty && !secondPIN.isEmpty && !thirdPIN.isEmpty && !fourthPIN.isEmpty {
            let username = viewModel.retrieveTempUsername()
            
            let pinNumber = firstPIN + secondPIN + thirdPIN + fourthPIN
            viewModel.updatePinNumber(username: username, pin: pinNumber)
            //            TempData.facialRecognitionAdded = true
            performSegue(withIdentifier: "to Setting View", sender: self)
        } else {
            alert.showWrongPinNumberAlert(on: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        populateTextFieldArray()
        // Connect all of the text fields
        UITextField.connectAllTxtFieldFields(txtfields: textFields)
        // Automatically show keyboard
        if checkAllEmptyInputs() == true {
            showKeyboard()
        }

        // Do any additional setup after loading the view.
    }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
