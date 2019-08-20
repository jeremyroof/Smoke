//
//  ContentView.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cookListVM: CookListViewModel
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    
    init() {
        self.cookListVM = CookListViewModel()
    }
    
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let cookVM = self.cookListVM.cooks[index]
            self.cookListVM.deleteCook(cookVM)
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
                    
                    Spacer()
                    
                    
                    // List Reload Button
                    Button(action: {
                        self.cookListVM.fetchAllCooks()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .imageScale(.large)
                    }.padding(.trailing)
                        .font(.subheadline)
                }
                
                List {
                    ForEach(self.cookListVM.cooks) { cook in
                        NavigationLink(destination: CookDetailView(cook: cook)) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(cook.name)
                                    .font(.title)
                                
                                HStack {
                                    Text(cook.type)
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
