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
    
    @IBOutlet weak var dateLabel: UILabel!
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
    @IBAction func foodButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.food.name
        
        for button in buttons {
            if button == foodButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func drinkButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.drink.name
        
        for button in buttons {
            if button == drinkButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func shopButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.shop.name
        
        for button in buttons {
            if button == shopButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func medicationButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.medication.name
        
        for button in buttons {
            if button == medicationButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func educationButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.education.name
        for button in buttons {
            if button == educationButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func utilitiesButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.utilities.name
        
        for button in buttons {
            if button == utilitiesButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func transportButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.transportation.name
        
        for button in buttons {
            if button == transportButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func rentButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.rent.name
        
        for button in buttons {
            if button == rentButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func othersButtonPressed(_ sender: Any) {
        TempData.itemCategory = Category.others.name
        
        for button in buttons {
            if button == othersButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    
    @IBAction func amountDidChange(_ sender: DesignableTextField) {
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
    

    private lazy var buttons:[DesignableButton] = [foodButton, drinkButton, shopButton, medicationButton, educationButton, utilitiesButton, transportButton, rentButton, othersButton]
    private let viewModel = ItemDetailScreenViewModel()
    private var currentDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
        amountTextField.addDoneButtonOnKeyboard()
        descriptionTextView.addDoneButtonOnKeyboard()
        
        currentDate = viewModel.getCurrentDate()
        TempData.itemDate = currentDate
        
        dateLabel.text = currentDate
        

        
    }
    
    // Hide keyboard when user touches anywhere in UIViewController
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    internal func textViewDidChange(_ textView: UITextView) {
        TempData.itemDescription = textView.text
    }
   
}
