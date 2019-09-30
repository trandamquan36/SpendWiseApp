//
//  PersistentContainer.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 11/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    func addNSUser(name:String, username:String, password:String, pinNumber:String){
        let user:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: persistentContainer.viewContext) as! User
        
        user.name = name
        user.username = username
        user.password = password
        user.pinNumber = pinNumber
        
        saveContext()
    }
    
    func addNSItem(id:UUID, title:String, date:String, amount:String, type:String, category:String, description: String, user:String) {
        
        let item:Item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: persistentContainer.viewContext) as! Item
        
        item.id = id
        item.title = title
        item.date = date
        item.amount = amount
        item.type = type
        item.category = category
        item.detail = description
        item.user = user
        
        saveContext()
    }
    
    func retrieveNSUsers() -> (names:[String], usernames:[String], passwords:[String], pins:[String] ) {
        var names:[String] = []
        var usernames:[String] = []
        var passwords:[String] = []
        var pins:[String] = []
        
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in searchResults as [User] {
                names.append(result.name!)
                usernames.append(result.username!)
                passwords.append(result.password!)
                pins.append(result.pinNumber!)
            }
        } catch {
            print("Error: \(error)")
        }
    
        return (names: names, usernames: usernames, passwords: passwords, pins: pins)
    }
    
    func retrieveNSItems(username: String) -> (ids:[UUID], titles:[String], dates:[String], amounts:[String], types:[String], categories:[String], descriptions:[String], users:[String]) {
        var ids:[UUID] = []
        var titles:[String] = []
        var dates:[String] = []
        var amounts:[String] = []
        var types:[String] = []
        var categories:[String] = []
        var descriptions:[String] = []
        var users:[String] = []
        
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let searchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in searchResults as [Item] {
                if result.user! == username {
                    ids.append(result.id!)
                    titles.append(result.title!)
                    dates.append(result.date!)
                    amounts.append(result.amount!)
                    types.append(result.type!)
                    categories.append(result.category!)
                    descriptions.append(result.detail!)
                    users.append(result.user!)
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        return (ids:ids, titles: titles, dates:dates, amounts:amounts, types:types, categories: categories, descriptions:descriptions, users:users)
        
    }
    
    func updateNSUserPassword(username:String, updateInfo:String) {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in searchResults as [User] {
                
                if username == result.username {
                    result.password = updateInfo
                    break
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        saveContext()
    }
    
    func updateNSUserName(username:String, updateInfo:String) {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in searchResults as [User] {
                
                if username == result.username {
                    result.name = updateInfo
                    break
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        saveContext()
    }
    
    func updateNSUserPinNumber(username:String, updateInfo:String) {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let searchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in searchResults as [User] {
                
                if username == result.username {
                    result.pinNumber = updateInfo
                    break
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        saveContext()
    }
    
    func updateNSItemInfo(id: UUID, username: String, title:String, amount:String, category:String, description:String) {
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let searchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in searchResults as [Item] {
                if id == result.id && username == result.user{
                    result.title = title
                    result.amount = amount
                    result.category = category
                    result.detail = description
                    break
                }
            }
        } catch {
            print ("Error: \(error)")
        }
        
        saveContext()
    }
    
    func deleteNSItem() {
        
    }
    
    
    
    // MARK: - Core Data stack
    
    private var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
  
    
}
