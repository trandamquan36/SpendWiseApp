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

        performSegue(withIdentifier: "AddItemScreen_SummaryScreen", sender: self)
    }
    @IBAction private func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        print("item category: \(TempData.itemCategory)")
        print("Valid amount: \(TempData.validAmount)")
        print("Valid title: \(TempData.validTitle)")
        if TempData.itemCategory != Category.none.name && TempData.validAmount == true && TempData.validTitle == true{
         
            let id = viewModel.generateID()
            
            viewModel.addItem(id: id, title: TempData.itemTitle, date: TempData.itemDate, amount: TempData.itemAmount, type: TempData.itemType, category: TempData.itemCategory, description: TempData.itemDescription, user: TempData.usernameInput)

            TempData.itemType = CustomItemType.none.name
            TempData.resetItemData()
            performSegue(withIdentifier: "AddItemScreen_SummaryScreen", sender: self)
        } else {
            alert.showInvalidAddItemAlert(on: self)
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
        TempData.itemType = CustomItemType.expense.name
        
    }

}

