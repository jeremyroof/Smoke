//
//  AddCookViewModel.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import Foundation
import SwiftUI

class AddCookViewModel: Identifiable {
    var name: String = ""
    var type: String = ""
    var weight: String = ""
    var date: Date = Date()
    var id: UUID = UUID()
    
    func saveCook() {
        CoreDataManager.shared.saveCook(name: self.name, type: self.type, weight: self.weight, date: self.date, id: self.id)
    }
}
