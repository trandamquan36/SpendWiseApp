//
//  CustomDateViewModel.swift
//  SpendWiseApp
//
//  Created by Hieu Ha on 26/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
struct CustomDateViewModel {
    private (set) var date = Date()
    private (set) var customDate = CustomDate()
    
    public init() {
        getCurrentDate()
    }
    
    mutating func getCurrentDate() {
        date = customDate.getCurrentDate()
    }
    
    mutating func addDate(day: Int = 0, month: Int = 0, year: Int = 0) {
        customDate.addDate(day: day, month: month, year: year)
    }
    
    mutating func getInstantDate() -> Date {
        date = customDate.getDate()
        
        return date
    }
}
