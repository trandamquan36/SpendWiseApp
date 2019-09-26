//
//  CustomIncomeType.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import UIKit

enum Category {
    // Expenses
    case drink
    case food
    case medication
    case education
    case shop
    case transportation
    case rent
    case utilities
   
    // Incomes
    case salary
    case donation
    
    case others
    case none
    
    var name:String {
        switch self {
        case .drink: return "Drink"
        case .food:  return "Food"
        case .medication: return "Medication"
        case .education: return "Education"
        case .shop: return "Shop"
        case .transportation: return "Transportation"
        case .rent: return "Rent"
        case .utilities: return "Utilities"
        case .salary: return "Salary"
        case .donation: return "Donation"
            
        case .others: return "Others"
        case .none: return "None"
        
        }
    }
    
    var image: UIImage {
        switch self{
        case .drink: return UIImage(named: "drink-icon")!
        case .food:  return UIImage(named: "food-icon")!
        case .medication: return UIImage(named: "medication-icon")!
        case .education: return UIImage(named: "education-icon")!
        case .shop: return UIImage(named: "shop-icon")!
        case .transportation: return UIImage(named: "transportation-icon")!
        case .rent: return UIImage(named: "rent-icon")!
        case .utilities: return UIImage(named: "utilities-icon")!
        case .salary: return UIImage(named: "salary-icon")!
        case .donation: return UIImage(named: "donation-icon")!
            
        case .others: return UIImage(named: "others-icon")!
        case .none: return UIImage(named: "noimage-icon")!
        }
    }
    
}
