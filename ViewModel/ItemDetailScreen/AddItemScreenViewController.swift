//
//  ItemScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class AddItemScreenViewController: UIViewController {
    private let alert = Alert()
    private let viewModel = AddItemScreenViewModel()
    
    
    @IBAction private func backBarButtonPressed(_ sender: Any) {
        TempData.itemType = CustomItemType.none.name
        TempData.resetItemData()
        if TempData.editMode == true {
            TempData.editMode = false
        }
        performSegue(withIdentifier: "AddItemScreen_SummaryScreen", sender: self)
    }
    @IBAction private func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        if TempData.itemCategory != Category.none.name && TempData.validAmount == true && TempData.validTitle == true{
            if TempData.editMode == true {
                viewModel.updateItem(id: TempData.itemID, title: TempData.itemTitle, amount: TempData.itemAmount, category: TempData.itemCategory, description: TempData.itemDescription, user: TempData.usernameInput)
                
            } else {
                let id = viewModel.generateID()
            
                viewModel.addItem(id: id, title: TempData.itemTitle, date: TempData.itemDate, amount: TempData.itemAmount, type: TempData.itemType, category: TempData.itemCategory, description: TempData.itemDescription, user: TempData.usernameInput)

              
            }
            TempData.itemType = CustomItemType.none.name
            TempData.resetItemData()
            performSegue(withIdentifier: "AddItemScreen_SummaryScreen", sender: self)
        } else {
            alert.showInvalidAddItemAlert(on: self)
        }
        if TempData.editMode == true {
            TempData.editMode = false
        }
    }
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    @IBAction private func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            expenseView.alpha = 1
            incomeView.alpha = 0
            TempData.itemType = CustomItemType.expense.name
            TempData.resetItemData()
        } else {
            expenseView.alpha = 0
            incomeView.alpha = 1
            TempData.itemType = CustomItemType.income.name
            TempData.resetItemData()
        }
        
    }
    @IBOutlet private weak var expenseView: UIView!
    @IBOutlet private weak var incomeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if TempData.editMode == true {
            
            segmentedControl.setEnabled(false, forSegmentAt: 0)
            segmentedControl.setEnabled(false, forSegmentAt: 1)
//            segmentedControl.backgroundColor = Colors.getColor(redColor: 119.0, greenColor: 136.0, blueColor: 153.0, alpha: 100.0)
//            segmentedControl.layer.borderColor = Colors.getColor(redColor: 119.0, greenColor: 136.0, blueColor: 153.0, alpha: 100.0).cgColor
            
            if TempData.itemType == CustomItemType.expense.name{
               // segmentedControl.selectedSegmentIndex = 0
                expenseView.alpha = 1
                incomeView.alpha = 0
               
            } else if TempData.itemType == CustomItemType.income.name {
               // segmentedControl.selectedSegmentIndex = 1
                expenseView.alpha = 0
                incomeView.alpha = 1

            }
        } else {
            TempData.itemType = CustomItemType.expense.name
            segmentedControl.setEnabled(true, forSegmentAt: 0)
            segmentedControl.setEnabled(true, forSegmentAt: 1)
//            segmentedControl.backgroundColor = Colors.getColor(redColor: 61.0, greenColor: 71.0, blueColor: 100.0, alpha: 100.0)
//            segmentedControl.layer.borderColor = Colors.getColor(redColor: 61.0, greenColor: 71.0, blueColor: 100.0, alpha: 100.0).cgColor
           
        }
    }

    
}
