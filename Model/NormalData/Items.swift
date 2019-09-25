//
//  IncomeType.swift
//  SpendWiseApp
//
//  Created by Jason Mach on 9/17/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import UIKit


enum IncomeType:String {
    case salary = "salary",donation = "donation"
    var categoriesName:String{
        switch self{
        case .salary: return "Salary"
        case .donation: return "Donation"
        }
    }
}

enum ExpenseType:String {
    case drink = "Drink",food = "Food",medication = "Medication",education = "Education",goceries = "Gorceries",transportation = "Transportation",rent = "Rent",utilities = "Utilities"
    var imageName:String{
        switch self{
        case .drink: return "drink"
        case .food: return "food"
        case .medication: return "medication"
        case .goceries: return "goceries"
        case .education: return "education"
        case .transportation: return "transportation"
        case .rent: return "rent"
        case .utilities: return "utilites"
        }
    }
}


enum ItemType:String {
    case expense="Expense",income="Income"
    
}



struct Items {
    private var description:String
    private var amount:Float
    private var date:String
    private var type:ItemType
    private var imageCategories:ExpenseType.RawValue
    private (set) var items:[Items]=[]
    
   
    
    var count:Int {
        return items.count
    }

 init(description:String,amount:Float,date:String,type:ItemType,imageCategories:ExpenseType.RawValue){
        self.description = description
        self.amount = amount
        self.date = date
        self.type = type
        self.imageCategories = imageCategories
    }
   
    private mutating func loadInitialExpenseData() {
        //        let cate1 = Categories(type: ItemType.expense, image: "drink")
        //        let cate2 = Categories(type: ItemType.expense, image: "food")
        //        let cate3 = Categories(type: ItemType.expense, image: "medication")
        //        let cate4 = Categories(type: ItemType.expense, image: "goceries")
        
        let expense1 = Items(description: "Betty Burger", amount: 6.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"drink")
        //        expense1.add(category: cate1)
        
        let expense2 = Items(description: "Udon Yasan", amount: 6.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"food")
        //        expense2.add(category: cate2)
        
        let expense3 = Items(description: "ance medication", amount: 3.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"medication")
        //        expense3.add(category: cate3)
        
        let expense4 = Items(description: "Wool worth", amount: 4.0, date: "17/09/2019",type:ItemType.expense,imageCategories:"goceries")
        //        expense4.add(category: cate4)
        
        
        items.append(expense1)
        items.append(expense2)
        items.append(expense3)
        items.append(expense4)
        
    }
    //    mutating func add(category:Categories) {
    //        // there might be multiple awarad across each year key need to be unique
    //
    //        self.categories = category
    //        //let key:St = category.type.rawValue + String(category.image)
    //
    //        //categories.updateValue(category,forKey:key)
    //    }
    
    func getCount() ->Int {
        return self.count
    }
    func getDescription() ->String {
        return self.description
    }
    func getAmount()  ->Float {
        return self.amount
    }
    func getDate() ->String {
        return self.date
    }
    func getType() ->String {
        return self.type.rawValue
    }
    func getImageName() -> String {
        return self.imageCategories
    }
    
   
    //func add newExpense(description,amount,date,type,imageName)
    //func addnewIncome(descr
    
    
    
    
    //func addNewExpense(description:String,amount:Float,date:String,)
}

// var expense6 = Items(description: "Udon Yasan", amount: 6.0, date: "17/09/2019")
//expense6.add(category: cate1)
