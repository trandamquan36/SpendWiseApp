//
//  IncomeScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class IncomeScreenViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var titleTextField: DesignableTextField!
    @IBOutlet weak var dateTextField: DesignableTextField!
    @IBOutlet weak var amountTextField: DesignableTextField!
    
    @IBOutlet weak var salaryButton: DesignableButton!
    @IBOutlet weak var donationButton: DesignableButton!
    @IBOutlet weak var othersButton: DesignableButton!
    @IBOutlet weak var descriptionTextView: DesignableTextView!
    
    @IBAction private func cameraPressed(_ sender: Any) {
        
    }
    
    @IBAction private func salaryButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.salary.name
        
        for button in buttons {
            if button == salaryButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    
    @IBAction private func donationButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.donation.name
        
        for button in buttons {
            if button == donationButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func othersButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.others.name
        
        for button in buttons {
            if button == othersButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    
    @IBAction private func titleDidChange(_ sender: Any) {
        guard let title = titleTextField.text else { return }
        
        if title.isEmpty == true {
            TempData.validTitle = false
            TempData.itemTitle = ""
            titleTextField.showError()
        } else {
            TempData.validTitle = true
            TempData.itemTitle = title
            titleTextField.showNothing()
        }
    }
    @IBAction private func amountDidChange(_ sender: Any) {
        guard let amount = amountTextField.text else { return }
        
        let isValidAmount:Bool = self.validation.validateAmount(string: amount)
        
        if amount.isEmpty == true || isValidAmount == false {
            TempData.validAmount = false
            TempData.itemAmount = ""
            amountTextField.showError()
        } else {
            TempData.validAmount = true
            TempData.itemAmount = amount
            amountTextField.showNothing()
        }
    }
    
    private lazy var buttons:[DesignableButton] = [salaryButton, donationButton, othersButton]
    private var textFields:[DesignableTextField] = []
    private let viewModel = AddItemScreenViewModel()
    private let validation = Validation()
    private var currentDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
        amountTextField.addDoneButtonOnKeyboard()
        descriptionTextView.addDoneButtonOnKeyboard()
        
        populateTextFields()
        UITextField.connectAllTxtFieldFields(txtfields: textFields)
        
        currentDate = viewModel.getCurrentDate()
        TempData.itemDate = currentDate
        dateTextField.text = currentDate
       
    }
    
    // Hide keyboard when user touches anywhere in UIViewController
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    internal func textViewDidChange(_ textView: UITextView) {
        TempData.itemDescription = textView.text
    }
    
    private func populateTextFields() {
        textFields.append(titleTextField)
        textFields.append(amountTextField)
    }
    
}
