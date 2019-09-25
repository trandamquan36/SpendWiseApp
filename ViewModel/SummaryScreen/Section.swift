//
//  Section.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 22/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//


import Foundation
struct Section {
    var type:String!
    var items:[(id:UUID, date:String, amount:String, itemType:String, expenseType:String, incomeType:String, description:String)]!
    var expanded:Bool!
    init(type:String, items:[(id:UUID, date:String, amount:String, itemType:String, expenseType:String, incomeType:String, description:String)],expanded:Bool) {
        self.type = type
        self.items = items
        self.expanded = expanded
    }
}
