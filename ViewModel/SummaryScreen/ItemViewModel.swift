////
////  ItemViewModel.swift
////  SpendWiseApp
////
////  Created by Jason Mach on 9/17/19.
////  Copyright © 2019 Quan Tran. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//struct ItemViewModel{
//    private (set) var items:[Items]=[]
//    private (set) var incomeItems:[Items] = []
//
//    var count:Int {
//        return items.count
//    }
//
//    var incomeCount:Int {
//        return incomeItems.count
//    }
//    init() {
//        loadExpenseData()
//    }
//    private mutating func loadExpenseData() {
//        let expense1 = Items(description: "Bang Bang", amount: 6.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"drink")
//        //        expense1.add(category: cate1)
//
//        let expense2 = Items(description: "Udon Yasan", amount: 6.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"food")
//        //        expense2.add(category: cate2)
//
//        let expense3 = Items(description: "ance medication", amount: 3.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"medication")
//        //        expense3.add(category: cate3)
//
//        let expense4 = Items(description: "Wool worth", amount: 4.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"goceries")
//        //
//        let income1 = Items(description: "Waiter Salary", amount: 56.0, date: "19/09/2019",type:ItemType.income,imageCategories:"salary")
//
//        let income2 = Items(description: "Hungry Jack Salary", amount: 56.0, date: "19/09/2019",type:ItemType.income,imageCategories:"salary")
//
//        let income3 = Items(description: "money from dad", amount: 2600, date: "20/09/2019",type:ItemType.income,imageCategories:"donation")
//
//
//
//        items.append(expense1)
//        items.append(expense2)
//        items.append(expense3)
//        items.append(expense4)
//
//
//        incomeItems.append(income1)
//        incomeItems.append(income2)
//        incomeItems.append(income3)
//
//
//    }
//
//
//    func getItem(byIndex index:Int) ->(description:String,amount:Float ,date:String,categories:String,image:UIImage?) {
//
//        let description = items[index].getDescription()
//        let amount = items[index].getAmount()
//        let date = items[index].getDate()
//        let categories = items[index].getImageName()
//        let image = UIImage(named:items[index].getImageName())
//
//        return (description,amount,date,categories,image)
//    }
//
//    func getIncomeItem(byIndex index:Int) ->(description:String,amount:Float ,date:String,categories:String,image:UIImage?) {
//
//        let description = incomeItems[index].getDescription()
//        let amount = incomeItems[index].getAmount()
//        let date = incomeItems[index].getDate()
//        let categories = incomeItems[index].getImageName()
//        let image = UIImage(named:incomeItems[index].getImageName())
//
//        return (description,amount,date,categories,image)
//    }
//
//    mutating func addNewExpense(description:String,amount:Float,date:String,type:ItemType,imageCategories:ExpenseType.RawValue) ->Void {
//        let expenseX = Items(description: description, amount: amount, date: date,type:type,imageCategories:imageCategories)
//
//        items.append(expenseX)
//    }
//
//    mutating func addNewIncome(description:String,amount:Float,date:String,type:ItemType,imageCategories:ExpenseType.RawValue) ->Void {
//        let incomeX = Items(description: description, amount: amount, date: date,type:type,imageCategories:imageCategories)
//
//        incomeItems.append(incomeX)
//    }
//
//    mutating func removeExpense(atRow:Int) {
//        items.remove(at: atRow)
//    }
//
//
//
//
//
//}
