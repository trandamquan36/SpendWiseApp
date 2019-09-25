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
    
    func getItemDataFromCoreData() ->(ids:[UUID], titles:[String], dates:[String], amounts:[String], itemTypes:[String], categories:[String], descriptions:[String]){
        
        var ids:[UUID] = []
        var titles:[String] = []
        var dates:[String] = []
        var amounts:[String] = []
        var itemTypes:[String] = []
        var categories:[String] = []
        var descriptions:[String] = []
        
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [Item] {
                ids.append(result.id!)
                titles.append(result.title!)
                dates.append(result.date!)
                amounts.append(result.amount!)
                itemTypes.append(result.type!)
                categories.append(result.category!)
                descriptions.append(result.detail!)
            }
        } catch {
            print("Error: \(error)")
        }
        
        return (ids:ids, titles: titles, dates:dates, amounts:amounts, itemTypes:itemTypes, categories: categories, descriptions:descriptions)
    }
}
