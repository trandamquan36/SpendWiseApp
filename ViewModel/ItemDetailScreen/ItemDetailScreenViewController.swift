//
//  ItemScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class ItemDetailScreenViewController: UIViewController {
    private let alert = Alert()
    private let viewModel = ItemDetailScreenViewModel()
    @IBAction private func backBarButtonPressed(_ sender: Any) {
        TempData.itemType = CustomItemType.none.getType()
        TempData.resetItemData()
        
        performSegue(withIdentifier: "ItemDetailScreen_SummaryScreen", sender: self)
    }
    @IBAction private func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        if (TempData.expenseType != CustomExpenseType.none.getType() || TempData.incomeType != CustomIncomeType.none.getType()) && TempData.validAmount == true {
            let id = viewModel.generateID()
            
            print("\(TempData.usernameInput), \(id), \(TempData.itemDate), \(TempData.itemAmount), \(TempData.itemType), \(TempData.expenseType), \(TempData.incomeType), \(TempData.itemDescription)")
            viewModel.saveDataToCoreData(id: id, date: TempData.itemDate, amount: TempData.itemAmount, itemType: TempData.itemType, expenseType: TempData.expenseType, incomeType: TempData.incomeType, description: TempData.itemDescription)

            TempData.itemType = CustomItemType.none.getType()
            TempData.resetItemData()
            
            performSegue(withIdentifier: "ItemDetailScreen_SummaryScreen", sender: self)
        } else {
            alert.showInvalidAddItemAlert(on: self)
        }
    }
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    @IBAction private func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            expenseView.alpha = 1
            incomeView.alpha = 0
            TempData.itemType = CustomItemType.expense.getType()
            TempData.resetItemData()
        } else {
            expenseView.alpha = 0
            incomeView.alpha = 1
            TempData.itemType = CustomItemType.income.getType()
            TempData.resetItemData()
        }
        
    }
    @IBOutlet private weak var expenseView: UIView!
    @IBOutlet private weak var incomeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TempData.itemType = CustomItemType.expense.getType()
        // Do any additional setup after loading the view.
//        if TempData.editMode == true {
//            segmentedControl.setEnabled(false, forSegmentAt: 0)
//            segmentedControl.setEnabled(false, forSegmentAt: 1)
//            segmentedControl.backgroundColor = Colors.getColor(redColor: 128.0, greenColor: 128.0, blueColor: 128.0, alpha: 100.0)
//            segmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.getColor(redColor: 119.0, greenColor: 136.0, blueColor: 153.0, alpha: 100.0)], for: .normal)
//            if TempData.itemType == CustomItemType.expense.getType() {
//                segmentedControl.selectedSegmentIndex = 0
//
//            } else {
//                segmentedControl.selectedSegmentIndex = 1
//            }
//        } else {
//            TempData.itemType = CustomItemType.expense.getType()
//        }
    }
}
