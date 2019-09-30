//
//  EditPasswordScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class FirstEditPasswordScreenViewController: UIViewController {
    private let viewModel = FirstEditPasswordScreenViewModel()
    private var passwordsInDatabase:[String] = []
    private let alert = Alert()
    private var textFields:[DesignableTextField] = []
    
    @IBOutlet weak var currentPasswordTextField: DesignableTextField!
    
    @IBAction func checkBtn(_ sender: UIButton) {
        guard let currentPassword = currentPasswordTextField.text else {return}

        if checkPassword(password: currentPassword) {

//            let editPassword2 = storyboard?.instantiateViewController(withIdentifier: "EditPasswordScreen2") as! SecondEditPasswordScreenViewController
//            let rootnav = UINavigationController(rootViewController: editPassword2)
//            self.present(rootnav, animated: true, completion: nil)
            
            performSegue(withIdentifier: "EditPasswordScreen2", sender: self)
        } else {
            alert.showInvalidPasswordAlert(on: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPasswordTextField.isSecureTextEntry = true
        
        textFields.append(currentPasswordTextField)
        UITextField.connectAllTxtFieldFields(txtfields: textFields)

        // Do any additional setup after loading the view.
    }
    private func checkPassword(password:String) -> Bool {
        var isExist:Bool = false
        passwordsInDatabase = viewModel.retrievePassword()
        
        for passwordInDatabase in passwordsInDatabase {
            if  password == passwordInDatabase {
                isExist = true
                break
            } else {
                isExist = false
            }
        }
        return isExist
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
