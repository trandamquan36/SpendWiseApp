//
//  CustomIncomeType.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

enum CustomIncomeType:String {
    case salary
    case donation
    case others
    case none
    
    //    var categoryName:String{
    //        switch self{
    //        case .salary: return "Salary"
    //        case .donation: return "Donation"
    //        case .others: return "Others"
    //        case .none: return "None"
    //        }
    //    }
    
    var imageName:String {
        switch self{
        case .salary: return "salary-icon"
        case .donation: return "donation-icon"
        case .others: return "others-icon"
        case .none: return "No image"
        }
    }
    
    func getType() -> String {
        return self.rawValue
    }
    
}
