//
//  ForgotPasswordScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 8/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class FirstForgotPasswordScreenViewController: UIViewController {
    private let viewModel = FirstForgotPasswordScreenViewModel()
    private let alert = Alert()
    
    private var usernames:[String] = []
    private var textFields:[DesignableTextField] = []
    @IBOutlet private weak var usernameTextField: DesignableTextField!
    
    @IBAction private func checkButton(_ sender: Any) {
        guard let username = usernameTextField.text else { return }
        
        if username.isEmpty == true {
            alert.showMissingUsernameAlert(on: self)
        }
        if checkIfUsernameExists(entered: username) == true {
            viewModel.saveTempUsername(username: username)
            performSegue(withIdentifier: "FP1_FP2", sender: self)
        } else {
            alert.showInvalidUsernameAlert(on: self)
            TempData.counter = 0
        }
    }
    
    @IBAction private func exitButton(_ sender: Any) {
        TempData.counter = 0
        performSegue(withIdentifier: "FP1_LoginScreen", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        populateTextFieldArray()
        UITextField.connectAllTxtFieldFields(txtfields: textFields)

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
    
    private func checkIfUsernameExists(entered:String) -> Bool {
        usernames = viewModel.getUsernameFromCoreData()
        var isExist:Bool = false
        for username in usernames {
            if entered == username {
                isExist = true
              
                break
            } else {
                isExist = false
                TempData.counter += 1
            }
            
        }
       
        return isExist
    }
    
    private func populateTextFieldArray() {
        textFields.append(usernameTextField)
    }
}
