//
//  EditProfileScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class EditProfileScreenViewController: UIViewController {
    private let viewModel = EditProfileScreenViewModel()
    private let validation = Validation()
    private let alert = Alert()
    
    @IBOutlet weak var nameLabel: UILabel!
    private var validName:Bool = false
    @IBOutlet weak var nameTextField: DesignableTextField!
    
    @IBAction func nameDidChange(_ sender: DesignableTextField) {
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
    
    
    @IBAction func doneBtn(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        if validName == true {
            let userName = viewModel.retrieveTempUsername()
            viewModel.updateName(username: userName, name: name)
            performSegue(withIdentifier: "Back To Setting Screen", sender: self)
        } else {
    alert.showIncompleteFormAlert(on: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
