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
        TempData.itemType = CustomItemType.none.name
        TempData.resetItemData()
        
        performSegue(withIdentifier: "ItemDetailScreen_SummaryScreen", sender: self)
    }
    @IBAction private func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        if TempData.itemCategory != Category.none.name && TempData.validAmount == true {
            let id = viewModel.generateID()
            
            viewModel.saveDataToCoreData(id: id, title: TempData.itemTitle, date: TempData.itemDate, amount: TempData.itemAmount, itemType: TempData.itemType, category: TempData.itemCategory, description: TempData.itemDescription)

            TempData.itemType = CustomItemType.none.name
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
        TempData.itemType = CustomItemType.expense.name
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
