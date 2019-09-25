//
//  CustomDate.swift
//  SpendWiseApp
//
//  Created by Hieu Ha on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

struct CustomDate{
    // Marked as optional as invalid construction data will produce a nil value
    private (set) var date:Date?
    
    init(day:Int, month:Int, year:Int, hour:Int = 0, minutes: Int = 0, timeZone:TimeZone = .current){
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = timeZone
        dateComponents.hour = hour
        dateComponents.minute = minutes
        
        let userCalendar = Calendar.current
        // Swift API here can return an Optional Value
        date = userCalendar.date(from: dateComponents)
    }
    
    init() {
        var dateComponents = DateComponents()
        dateComponents.timeZone = .current
        dateComponents.hour = 0
        dateComponents.minute = 0
        
        let userCalendar = Calendar.current
        
        date = userCalendar.date(from: dateComponents)
    }
    
    func getCurrentDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.timeZone = .current
        dateComponents.hour = 0
        dateComponents.minute = 0
        
        let userCalendar = Calendar.current
        
        return userCalendar.date(from: dateComponents)!
    }
    
    mutating func addDate(day:Int = 0, month: Int = 0, year: Int = 0) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let userCalendar = Calendar.current
        
        date = userCalendar.date(byAdding: dateComponents, to: date!)
    }
    
    mutating func setDate(date:Date) {
        self.date = date
    }
    
    func getDate() -> Date{
        return date!
    }
}
