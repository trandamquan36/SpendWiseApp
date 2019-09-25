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
    var items:[(id:UUID, title:String, date:String, amount:String, itemType:String, category:String, description:String)]!
    var expanded:Bool!
    init(type:String, items:[(id:UUID, title:String, date:String, amount:String, itemType:String, category:String , description:String)],expanded:Bool) {
        self.type = type
        self.items = items
        self.expanded = expanded
    }
}
