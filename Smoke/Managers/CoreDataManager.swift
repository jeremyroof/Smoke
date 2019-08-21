//
//  CoreDataManager.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import Foundation
import CoreData

public class CookData: NSManagedObject, Identifiable {
    @NSManaged public var name: String?
    @NSManaged public var weight: String?
    @NSManaged public var type: String?
    @NSManaged public var date: Date
    @NSManaged public var cookID: UUID?
}

extension CookData {
    // The @FetchRequest property wrapper in the ContentView will call this function
    static func allCooksFetchRequest() -> NSFetchRequest<CookData> {
        let request: NSFetchRequest<CookData> = CookData.fetchRequest() as! NSFetchRequest<CookData>
        
        // The @FetchRequest property wrapper in the ContentView requires a sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
          
        return request
    }
}
