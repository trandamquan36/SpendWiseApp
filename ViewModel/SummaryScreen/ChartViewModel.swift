//
//  ChartViewModel.swift
//  SpendWiseApp
//
//  Created by Hieu Ha on 17/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import Charts

struct ChartViewModel {
    //Model
    private var record: ChartData = ChartData()
    private var customDate = CustomDate()
    
    func getRecord() -> ChartData {
        return record
    }
    
    // MARK: - Update Date Value
    mutating func setDate(day: Int, month: Int, year: Int = 2019) {
        let currentDate = CustomDate(day: day, month: month, year: year)
        
        self.customDate = currentDate
    }
    
    mutating func getDate() -> Date {
        
        return self.customDate.date!
    }
    
    func getCustomDate(day: Int, month: Int, year: Int = 2019) -> Date {
        let currentDate = CustomDate(day: day, month: month, year: year)
        
        return currentDate.date!
    }
    
    mutating func addDate(day: Int = 0, month: Int = 0, year: Int = 0) {
        customDate.addDate(day: day, month: month, year: year)
        
    }
    
    // MARK: - Update Chart Data
    //update the data
    mutating func update(at day: Date, income: Double, expense: Double) {
        record.update(day: day, income: income, expense: expense)
    }
    
    mutating func add(at day: Date, income: Double, expense: Double) {
        let instantIncome = record.getIncome(at: day) + income
        let instantExpense = record.getExpense(at: day) + expense
        
        record.update(day: day, income: instantIncome, expense: instantExpense)
    }
    
    mutating func createBar(fromDay from: Date, toDay to: Date) -> BarChartData
    {
        var dataEntries: [BarChartDataEntry] = []
        
        var dataEntry = BarChartDataEntry(x: Double(1), y: Double(record.getIncome(at: from)))
        dataEntries.append(dataEntry)
        
        dataEntry = BarChartDataEntry(x: Double(2), y: Double(record.getExpense(at: from)))
        dataEntries.append(dataEntry)
        
        dataEntry = BarChartDataEntry(x: Double(4), y: Double(record.getIncome(at: to)))
        dataEntries.append(dataEntry)
        
        dataEntry = BarChartDataEntry(x: Double(5), y: Double(record.getExpense(at: to)))
        dataEntries.append(dataEntry)
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "income/outcome")
        chartDataSet.colors = [UIColor(red: 0/255, green: 126/255, blue: 0/255, alpha: 1), UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)]
        
        return BarChartData(dataSet: chartDataSet)
    }
    
    mutating func updateDataForChart(dates: [String], amounts: [String], itemTypes: [String]) {
        var totalExpense: Double = 0.0
        var totalIncome: Double = 0.0
        
        var instantDate = CustomDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        for date in dates {
            for i in 0...dates.count - 1 {
                if itemTypes[i] == CustomItemType.expense.getType() {
                    if let instantAmount = Double(amounts[i]) {
                        totalExpense += instantAmount
                    }
                } else if itemTypes[i] == CustomItemType.income.getType() {
                    if let instantAmount = Double(amounts[i]) {
                        totalIncome += instantAmount
                    }
                }
            }
            
            instantDate.setDate(date: dateFormatter.date(from: date)!)
            record.update(day: instantDate.getDate(), income: totalIncome, expense: totalExpense)
            totalExpense = 0
            totalIncome = 0
        }
    
}
}
