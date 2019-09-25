//
//  GoalSetterData.swift
//  SpendWiseApp
//
//  Created by Hieu Ha on 20/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation

struct GoalSetterData {
    private (set) var goal: Double = 0
    private (set) var expense: Double = 0
    
    mutating func setGoal(amount: Double) {
        self.goal = amount
    }
    
    mutating func addExpense(amount: Double) {
        expense += amount
    }
    
    mutating func clearExpense() {
        self.expense = 0
    }
    
    func getGoalValue() -> Double {
        return goal
    }
    
    func getExpenseValue() -> Double {
        return expense
    }
    
    mutating func getColor() -> ChartColor {
        var color: ChartColor = .green
        
        if goal != 0 {
            let result = expense * 100 / goal
            if result <= 30 && result >= 0 {
                color = .green
            } else if result > 30 && result <= 70 {
                color = .yellow
            } else {
                color = .red
            }
        }
        
        return color
    }
}
