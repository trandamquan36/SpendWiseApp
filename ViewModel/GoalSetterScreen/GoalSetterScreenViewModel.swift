//
//  GoalSetterViewModel.swift
//  SpendWiseApp
//
//  Created by Hieu Ha on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import Charts

struct GoalSetterViewModel {
    private (set) var goalSetterData: GoalSetterData = GoalSetterData()
    
    mutating func setGoal(goal:Double) {
        goalSetterData.setGoal(amount: goal)
    }
    
    mutating func addExpense(expense: Double) {
        goalSetterData.addExpense(amount: expense)
    }
    
    func getColor(color: ChartColor, pieChartDataSet: PieChartDataSet) -> PieChartDataSet {
        switch color {
        case .red:
            pieChartDataSet.colors = [UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1), UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)]
            
        case .green:
            pieChartDataSet.colors = [UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1), UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)]
            
        case .yellow:
            pieChartDataSet.colors = [UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1), UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)]
        }
        
        return pieChartDataSet
    }
    
    mutating func createPie() -> PieChartData
    {
        var dataEntries: [PieChartDataEntry] = []
        
        var dataEntry = PieChartDataEntry(value: goalSetterData.goal - goalSetterData.expense, label: "Remains")
        dataEntries.append(dataEntry)
        
        dataEntry = PieChartDataEntry(value: goalSetterData.expense, label: "Expense")
        dataEntries.append(dataEntry)
        
        var chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        chartDataSet = self.getColor(color: goalSetterData.getColor(), pieChartDataSet: chartDataSet)
        
        
        
        return PieChartData(dataSet: chartDataSet)
    }
}
