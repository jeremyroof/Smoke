//
//  CookListViewModel.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class CookListViewModel: ObservableObject, Identifiable {
    
    @Published
    var cooks = [CookViewModel]()
    
    init() {
        fetchAllCooks()
    }
    
    func deleteCook(_ cookVM: CookViewModel) {
        CoreDataManager.shared.deleteCook(name: cookVM.name)
        fetchAllCooks()
    }
    
    func fetchAllCooks() {
        self.cooks = CoreDataManager.shared.getAllCooks().map(CookViewModel.init)
        //print(self.cooks)
    }
}

class CookViewModel: Identifiable {
    var name = ""
    var type = ""
    var date: Date
    var weight = ""
    var id: UUID
    
    init(cook: Cook) {
        self.name = cook.name!
        self.type = cook.type!
        self.date = cook.date!
        self.weight = cook.weight!
        self.id = cook.id!
    }
}
