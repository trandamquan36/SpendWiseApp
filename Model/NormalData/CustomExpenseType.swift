//
//  CustomExpenseType.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

enum CustomExpenseType:String {
    case drink, food , medication ,
    education , shop , transportation ,
    rent , utilities, others ,
    none
    
    //
    //    var categoryName:String{
    //        switch self{
    //        case .drink: return "Drink"
    //        case .food: return "Food"
    //        case .medication: return "Medication"
    //        case .education: return "Education"
    //        case .shop: return "Shop"
    //        case .transportation: return "Transportation"
    //        case .rent: return "Rent"
    //        case .utilities: return "Utilities"
    //        case .others: return "Others"
    //        case .none: return "None"
    //        }
    //    }
    
    var imageName:String{
        switch self{
        case .drink: return "drink-icon"
        case .food: return "food-icon"
        case .medication: return "medication-icon"
        case .shop: return "shop-icon"
        case .education: return "education-icon"
        case .transportation: return "transportation-icon"
        case .rent: return "rent-icon"
        case .utilities: return "utilites-icon"
        case .others: return "others-icon"
        case .none: return "No image"
        }
    }
    
    func getType() -> String {
        return self.rawValue
    }
    
}
