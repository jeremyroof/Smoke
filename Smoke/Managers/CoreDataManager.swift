//
//  CoreDataManager.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: Identifiable {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func fetchCook(name: String) -> Cook? {
        var cooks = [Cook]()
        
        let request: NSFetchRequest<Cook> = Cook.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            cooks = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        
        return cooks.first
    }
    
    func deleteCook(name: String) {
        do {
            if let cook = fetchCook(name: name) {
                self.moc.delete(cook)
                try self.moc.save()
            }
        }catch let error as NSError {
            print(error)
        }
    }
    
    func getAllCooks() -> [Cook] {
        var cooks = [Cook]()
        
        let cookRequest: NSFetchRequest<Cook> = Cook.fetchRequest()
        
        do {
            cooks = try self.moc.fetch(cookRequest)
        }catch let error as NSError {
            print(error)
        }
        return cooks
    }
    
    func saveCook(name: String, type: String, weight: String, date: Date, id: UUID) {
        let cook = Cook(context: self.moc)
        cook.name = name
        cook.type = type
        cook.weight = weight
        cook.date = date
        cook.id = id
                
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
