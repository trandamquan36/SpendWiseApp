//
//  EditPinScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class FirstEditPinScreenViewController: UIViewController {
    private let viewModel = FirstEditPinScreenViewModel()
    private let alert = Alert()
    //    private var userPinNumber:(firstPin:String, secondPin:String, thirdPin:String, fourthPin:String)?
    private var textFields:[DesignableTextField] = []
    private var pinNumbers:[String] = []
    private var pinsInDatabase:[String] = []
    
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
    
    @IBAction func checkBtn(_ sender: Any) {
        guard let firstPIN = firstPin.text, let secondPIN = secondPin.text,
            let thirdPIN = thirdPin.text, let fourthPIN = fourthPin.text
            else { return }
        
        if !firstPIN.isEmpty && !secondPIN.isEmpty && !thirdPIN.isEmpty && !fourthPIN.isEmpty {
            let pinNumber = firstPIN + secondPIN + thirdPIN + fourthPIN
            if checkPINNumber(pinNumber: pinNumber) == true {
                performSegue(withIdentifier: "To Edit PIN Screen 2", sender: self)
            } else {
                alert.showWrongPinNumberAlert(on: self)
            }
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
    private func checkPINNumber(pinNumber:String) -> Bool {
        var isSame:Bool = false
        pinsInDatabase = viewModel.getPINFromCoreData()
        
        for pinInDatabase in pinsInDatabase {
            print(pinInDatabase)
            if  pinNumber == pinInDatabase {
                isSame = true
                break
            } else {
                isSame = false
            }
        }
        return isSame
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
