//
//  IncomeScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class IncomeScreenViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountTextField: DesignableTextField!
    
    @IBOutlet weak var salaryButton: DesignableButton!
    @IBOutlet weak var donationButton: DesignableButton!
    @IBOutlet weak var othersButton: DesignableButton!
    @IBOutlet weak var descriptionTextView: DesignableTextView!
    
    
    @IBAction func salaryButtonPressed(_ sender: Any) {
        TempData.incomeType = CustomIncomeType.salary.getType()
        
        for button in buttons {
            if button == salaryButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    
    @IBAction func donationButtonPressed(_ sender: Any) {
        TempData.incomeType = CustomIncomeType.donation.getType()
        
        for button in buttons {
            if button == donationButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    @IBAction func othersButtonPressed(_ sender: Any) {
        TempData.incomeType = CustomIncomeType.others.getType()
        
        for button in buttons {
            if button == othersButton {
                button.pressed()
            } else {
                button.notPressed()
            }
        }
    }
    
    @IBAction func amountDidChange(_ sender: Any) {
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
    private let viewModel = ItemDetailScreenViewModel()
    private let validation = Validation()
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
