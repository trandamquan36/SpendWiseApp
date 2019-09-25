//
//  CustomItemType.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

enum CustomItemType {
    case income
    case expense
    case none
    
    var name:String {
        switch self {
        case .income: return "Income"
        case .expense: return "Expense"
        case .none: return "None"
        }
    }
}
