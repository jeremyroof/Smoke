//
//  AddCookView.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import SwiftUI

struct AddCookView: View {
    
    @State var addCookVM = AddCookViewModel()
    @State var cookDate = Date()
    @State var cutName = ""
    @State var weight = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    
    var body: some View {
        //NavigationView {
            Form{
                Section {
                    TextField("Enter Cut", text: $cutName)
                    TextField("Weight", text: $weight)
                }
                
                Section{
                    
                    DatePicker(selection: $cookDate) {
                        Text("Cook Date:")
                    }
                    
                    
                    Picker(selection: self.$addCookVM.type, label: Text("")) {
                        Text("Beef").tag("Beef")
                        Text("Poultry").tag("Poultry")
                        Text("Pork").tag("Pork")
                        Text("Seafood").tag("Seafood")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                    
                HStack {
                    Spacer()
                    Button(action: {
                        self.addCookVM.date = self.cookDate
                        self.addCookVM.name = self.cutName
                        self.addCookVM.weight = self.weight
                        self.addCookVM.saveCook()
                    }) {
                        Text("Add to log")
                    }.padding(8)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    Spacer()
                }
            }.padding()
            .navigationBarTitle("Add Cook")
        //}
    }
}

#if DEBUG
struct AddCookView_Previews: PreviewProvider {
    static var previews: some View {
        AddCookView()
    }
}
#endif
