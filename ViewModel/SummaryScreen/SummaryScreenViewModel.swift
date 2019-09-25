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
    func getItemDataFromCoreData() ->(ids:[UUID], dates:[String], amounts:[String], itemTypes:[String], expenseTypes:[String], incomeTypes:[String], descriptions:[String]){
        var ids:[UUID] = []
        var dates:[String] = []
        var amounts:[String] = []
        var itemTypes:[String] = []
        var expenseTypes:[String] = []
        var incomeTypes:[String] = []
        var descriptions:[String] = []
        
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let searchResults = try CoreDataManager.getContext().fetch(fetchRequest)
            
            for result in searchResults as [Item] {
                ids.append(result.id!)
                dates.append(result.date!)
                amounts.append(result.amount!)
                itemTypes.append(result.type!)
                expenseTypes.append(result.expenseType!)
                incomeTypes.append(result.incomeType!)
                descriptions.append(result.detail!)
            }
        } catch {
            print("Error: \(error)")
        }
        
        return (ids:ids, dates:dates, amounts:amounts, itemTypes:itemTypes, expenseTypes:expenseTypes, incomeTypes:incomeTypes, descriptions:descriptions)
    }
}
