//
//  ChartSumaryData.swift
//  SpendWiseApp
//
//  Created by Hieu Ha on 17/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

struct ChartData {
    
    private (set) var chartListData: [Date:(Double, Double)] = [:]
    
    mutating func update(day: Date, income: Double, expense: Double) {
        chartListData.updateValue((income, expense), forKey: day)
    }
    
    public func getChartData() -> [Date:(Double, Double)]{
        return chartListData
    }
    
    public mutating func getExpense(at day:Date) -> Double{
        let expense = chartListData[day]?.0
        
        return expense ?? 0
    }
    
    public mutating func getIncome(at day:Date) -> Double{
        let income = chartListData[day]?.1
        
        return income ?? 0
    }
}
