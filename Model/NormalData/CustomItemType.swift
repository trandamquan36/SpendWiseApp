//
//  CustomItemType.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

enum CustomItemType:String {
    case income
    case expense
    case none
    
    func getType() -> String {
        return self.rawValue
    }
}
