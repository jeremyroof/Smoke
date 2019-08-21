//
//  EditCookView.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/19/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import SwiftUI

struct EditCookView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.presentationMode) var presentationMode
    
    var thisCook: CookData
    @State var updatedName = ""
    @State var updatedWeight = ""
    @State var updatedType = ""
    @State var updatedDate = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    
    var body: some View {
        Form {
            Section {
                TextField("Cut Name", text: $updatedName).onAppear {
                    self.updatedName = self.thisCook.name ?? ""
                }
                
                TextField("Weight", text: $updatedWeight).onAppear {
                    self.updatedWeight = self.thisCook.weight ?? ""
                }
                
                Section{
                    
                    DatePicker(selection: $updatedDate) {
                        Text("Cook Date:")
                    }
                    
                    
                    Picker(selection: $updatedType, label: Text("")) {
                        Text("Beef").tag("Beef")
                        Text("Poultry").tag("Poultry")
                        Text("Pork").tag("Pork")
                        Text("Seafood").tag("Seafood")
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
            
            HStack {
                Spacer()
                Button(action: {
                    self.thisCook.name = self.updatedName
                    self.thisCook.weight = self.updatedWeight
                    self.thisCook.type = self.updatedType
                    self.thisCook.date = self.updatedDate
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Changes")
                }.padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.green)
                    .cornerRadius(10)
                
                Spacer()
            }
        }
    }
}


/*
#if DEBUG
struct EditCookView_Previews: PreviewProvider {
    static var previews: some View {
        EditCookView()
    }
}
#endif */
