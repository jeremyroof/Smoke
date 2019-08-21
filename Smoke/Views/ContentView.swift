//
//  ContentView.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: CookData.allCooksFetchRequest()) var cooks: FetchedResults<CookData>
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let cookToDelete = self.cooks[index]
            self.managedObjectContext.delete(cookToDelete)
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                HStack {
                    // Create a new cook
                    NavigationLink(destination: AddCookView()) {
                        Text("Start a new cook")
                    }.font(.title)
                        .padding(.leading)
                }
                
                List {
                    ForEach(self.cooks) { cook in
                        NavigationLink(destination: CookDetailView(cook: cook)) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(cook.name!)
                                    .font(.title)
                                
                                HStack {
                                    Text(cook.type ?? "")
                                        .font(.subheadline)
                                        .padding(.leading)
                                    
                                    Text("\(cook.date, formatter: self.dateFormatter)")
                                }
                            }
                        }
                    }.onDelete(perform: delete)
                }
            }.navigationBarTitle("Cooks")
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
