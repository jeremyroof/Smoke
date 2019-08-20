//
//  EditCookView.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/19/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import SwiftUI

struct EditCookView: View {
    
    var thisCook: CookViewModel
    @State var name = ""
    
    
    var body: some View {
        Form {
            VStack {
                TextField("\(thisCook.name)", text: $name)
            }
            
            
            HStack {
                Spacer()
                Button(action: {
                    self.thisCook.name = self.name
                    AddCookViewModel().saveCook()
                }) {
                    Text("Add to log")
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
