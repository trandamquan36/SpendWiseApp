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
    private let dataManager = CoreDataManager.shared
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
    
    func retrieveRemainAmountFromItems(currentDate: String, currentTime: String, username: String) -> Float{

        let itemInfo = dataManager.retrieveNSItems(username: username)
        
        let itemTypes:[String] = itemInfo.types
        let itemDates:[String] = itemInfo.dates
        let itemTimes:[String] = itemInfo.times
        let itemAmounts:[String] = itemInfo.amounts
        
        
        var incomes:[(date: String, time: String, amount: String)] = []
        var expenses:[(date: String, time: String, amount: String)] = []
        var remainAmount:Float = 0.0
        
        if itemTypes.count > 0 {
            for index in 0...itemTypes.count - 1{
                if itemTypes[index] == CustomItemType.income.name {
                    incomes.append((itemDates[index], itemTimes[index], itemAmounts[index]))
                } else if itemTypes[index] == CustomItemType.expense.name {
                    expenses.append((itemDates[index], itemTimes[index], itemAmounts[index]))
                }
            }
            
            for index in 0...incomes.count - 1{
                let incomeDate = incomes[index].date.toDate(withFormat: "dd/MM/yyyy")
                let expenseDate = expenses[index].date.toDate(withFormat: "dd/MM/yyyy")
                
                let incomeTime = incomes[index].time.toDate(withFormat: "HH:mm:ss")
                let expenseTime = expenses[index].time.toDate(withFormat: "HH:mm:ss")
                
                let beginDate = currentDate.toDate(withFormat: "dd/MM/yyyy")
                let beginTime = currentTime.toDate(withFormat: "HH:mm:ss")
                
                if (incomeDate >= beginDate && incomeTime >= beginTime) {
                    remainAmount += Float(incomes[index].amount)!
                }
                
                if (expenseDate >= beginDate && expenseTime >= beginTime) {
                    remainAmount -= Float(expenses[index].amount)!
                }
            }
            
        }
       return remainAmount
    }
    
}


extension String {
    
    func toDate(withFormat format: String)-> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
//        let date = dateFormatter.date(from: self)
        
        return date!
        
    }
}
