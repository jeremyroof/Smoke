//
//  NSManagedObjectContext+Extensions.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
