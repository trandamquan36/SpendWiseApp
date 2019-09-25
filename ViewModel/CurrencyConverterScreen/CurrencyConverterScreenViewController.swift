//
//  CurrencyConverterScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class CurrencyConverterScreenViewController: UIViewController {
    private var alert = Alert()
    private var validation = Validation()
    private var validAmount:Bool = false
    @IBOutlet private weak var inputAmountTextField: DesignableTextField!
    @IBOutlet private weak var outputLabel: UILabel!
    @IBOutlet weak var errorLabel: DesignableLabel!
    
    
    @IBAction private func amountDidChange(_ sender: Any) {
        guard let inputAmount = inputAmountTextField.text else { return }
        let isValidInputAmount:Bool = self.validation.validateAmount(string: inputAmount)
        
        if inputAmount.isEmpty {
            validAmount = false
            inputAmountTextField.showError()
            errorLabel.showErrorText(text: "Amount cannot be empty!")
        } else if isValidInputAmount == false {
            validAmount = false
            inputAmountTextField.showError()
            errorLabel.showErrorText(text: "Amount must be a number")
        } else {
            validAmount = true
            inputAmountTextField.showNothing()
            errorLabel.text = ""
        }
    }
    
    @IBAction private func usdBtn(_ sender: Any) {
        guard let inputAmount = inputAmountTextField.text else {return}
        
        if validAmount == false {
            alert.showInvalidNumberAlert(on: self)
        } else {
            let input = Double(inputAmount)
            outputLabel.text = "\(input! * 1.48) AUD"
        }
    }
    @IBAction private func audBtn(_ sender: Any) {
        guard let inputAmount = inputAmountTextField.text else {return}
        
        
        if validAmount == false {
            alert.showInvalidNumberAlert(on: self)
        } else {
            let input = Double(inputAmount)
            outputLabel.text = "\(input! * 0.68) USD"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
