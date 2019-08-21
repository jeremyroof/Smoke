//
//  AddCookView.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/6/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import SwiftUI
import Combine

struct AddCookView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(fetchRequest: CookData.allCooksFetchRequest()) var cooks: FetchedResults<CookData>
    
    @ObservedObject private var newCookDate = MasterDate()
    @State private var newCutName = ""
    @State private var newCutWeight = ""
    @State private var newCutType = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    
    var body: some View {
        //NavigationView {
            Form{
                Section {
                    TextField("Enter Cut", text: self.$newCutName)
                    TextField("Enter Weight", text: self.$newCutWeight)
                }
                
                Section{
                    
                    DatePicker(selection: $newCookDate.theDate) {
                        Text("Cook Date:")
                    }
                    
                    
                    Picker(selection: self.$newCutType, label: Text("")) {
                        Text("Beef").tag("Beef")
                        Text("Poultry").tag("Poultry")
                        Text("Pork").tag("Pork")
                        Text("Seafood").tag("Seafood")
                    }.pickerStyle(SegmentedPickerStyle())
                }
                    
                HStack {
                    Spacer()
                    
                    Button(action: ({
                        // ❇️ Initializes new BlogIdea and saves using the @Environment's managedObjectContext
                        let cook = CookData(context: self.managedObjectContext)
                        cook.name = self.newCutName
                        cook.weight = self.newCutWeight
                        cook.date = self.newCookDate.theDate
                        cook.type = self.newCutType
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        
                        // ℹ️ Reset the temporary in-memory storage variables for the next new blog idea!
                        self.newCutName = ""
                        self.newCutWeight = ""
                        
                        self.presentationMode.wrappedValue.dismiss()
                    })) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                            Text("Add Cook")
                        }
                    }
                    .padding()
                }.navigationBarTitle("Add Cook")
        }
    }
}


class MasterDate: ObservableObject {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: CookData.allCooksFetchRequest()) var cooks: FetchedResults<CookData>
    
    @Published var theDate =  Date()
}




#if DEBUG
struct AddCookView_Previews: PreviewProvider {
    static var previews: some View {
        AddCookView()
    }
}
#endif
