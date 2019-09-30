//
//  ExpenseScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class ExpenseScreenViewController: UIViewController, UITextViewDelegate {
    
    private let validation = Validation()
    
  
    @IBOutlet weak var titleTextField: DesignableTextField!
    @IBOutlet weak var dateTextField: DesignableTextField!
    @IBOutlet weak var amountTextField: DesignableTextField!
    @IBOutlet weak var foodButton: DesignableButton!
    @IBOutlet weak var drinkButton: DesignableButton!
    @IBOutlet weak var shopButton: DesignableButton!
    @IBOutlet weak var medicationButton: DesignableButton!
    @IBOutlet weak var educationButton: DesignableButton!
    @IBOutlet weak var utilitiesButton: DesignableButton!
    @IBOutlet weak var transportButton: DesignableButton!
    @IBOutlet weak var rentButton: DesignableButton!
    @IBOutlet weak var othersButton: DesignableButton!
    @IBOutlet weak var descriptionTextView: DesignableTextView!
    
    @IBAction private func foodButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.food.name
        
        for button in buttons {
            if button == foodButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func drinkButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.drink.name
        
        for button in buttons {
            if button == drinkButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func shopButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.shop.name
        
        for button in buttons {
            if button == shopButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func medicationButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.medication.name
        
        for button in buttons {
            if button == medicationButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func educationButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.education.name
        for button in buttons {
            if button == educationButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func utilitiesButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.utilities.name
        
        for button in buttons {
            if button == utilitiesButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func transportButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.transportation.name
        
        for button in buttons {
            if button == transportButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction private func rentButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.rent.name
        
        for button in buttons {
            if button == rentButton {
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
    
    @IBAction private func amountDidChange(_ sender: DesignableTextField) {
        guard let amount = amountTextField.text else { return }
        
        let isValidAmount:Bool = self.validation.validateAmount(string: amount)
        
        if amount.isEmpty == true || isValidAmount == false {
            TempData.validAmount = false
            TempData.itemAmount = ""
            amountTextField.showError()
        } else {
            TempData.validAmount = true
            amountTextField.showNothing()
            TempData.itemAmount = amount
        }
    }
    
    @IBAction private func titleDidChange(_ sender: Any) {
        guard let title = titleTextField.text else { return }
        
        if title.isEmpty == true {
            TempData.validTitle = true
            TempData.itemTitle = ""
            titleTextField.showError()
        } else {
            TempData.validTitle = true
            TempData.itemTitle = title
            titleTextField.showNothing()
        }
    }
    private lazy var buttons:[DesignableButton] = [foodButton, drinkButton, shopButton, medicationButton, educationButton, utilitiesButton, transportButton, rentButton, othersButton]
    private var textFields:[DesignableTextField] = []
    private let viewModel = AddItemScreenViewModel()
    private var currentDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
        amountTextField.addDoneButtonOnKeyboard()
        descriptionTextView.addDoneButtonOnKeyboard()
        
        currentDate = viewModel.getCurrentDate()
        TempData.itemDate = currentDate
        dateTextField.text = currentDate
        
        populateTextFields()
        UITextField.connectAllTxtFieldFields(txtfields: textFields)
        
        if TempData.editMode == true {
            updateExpenseInfo(date: TempData.itemDate, title: TempData.itemTitle, amount: TempData.itemAmount, category: TempData.itemCategory, description: TempData.itemDescription)
        }

        
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
    
    func updateExpenseInfo(date: String, title: String, amount: String, category:String, description:String) {
        dateTextField.text = date
        titleTextField.text = title
        amountTextField.text = amount
        descriptionTextView.text = description
        
        switch category {
        case "Food": foodButton.pressed()
        case "Drink": drinkButton.pressed()
        case "Shop": shopButton.pressed()
        case "Medication": medicationButton.pressed()
        case "Education": educationButton.pressed()
        case "Utilities": utilitiesButton.pressed()
        case "Transportation": transportButton.pressed()
        case "Rent": rentButton.pressed()
        case "Others": othersButton.pressed()
        default: foodButton.notPressed()
        }
        
    }
}
