//
//  SummaryScreenViewModel.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 21/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData

struct SummaryScreenViewModel {
    private let dataManager = CoreDataManager.shared
    
    private (set) var now = Date()
    
    func getCurrentDate() ->Date  {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return now
    }
    
    private (set) var tomorrow = Date()
    
    func getTomorrowDate() ->Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return tomorrow+3600*24
        
    }
    
    func retrieveItemInfo(username: String) ->(ids:[UUID], titles:[String], dates:[String], amounts:[String], types:[String], categories:[String], descriptions:[String]){
        
        let itemInfo = dataManager.retrieveNSItems(username: username)
        
        let ids = itemInfo.ids
        let titles = itemInfo.titles
        let dates = itemInfo.dates
        let amounts = itemInfo.amounts
        let types = itemInfo.types
        let categories = itemInfo.categories
        let descriptions = itemInfo.descriptions
    
        return (ids:ids, titles: titles, dates:dates, amounts:amounts, types:types, categories: categories, descriptions:descriptions)
    }
    
    func deleteItemInfo(id: UUID, username:String) {
        dataManager.deleteNSItem(id: id, username: username)
    }
}
