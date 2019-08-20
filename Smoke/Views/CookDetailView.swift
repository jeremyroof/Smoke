//
//  CookDetailView.swift
//  Smoke
//
//  Created by Jeremy Roof on 8/11/19.
//  Copyright © 2019 Jeremy Roof. All rights reserved.
//

import SwiftUI

struct CookDetailView: View {
    
    var cook: CookViewModel
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        //NavigationView {
            VStack {
                NavigationLink(destination: EditCookView(thisCook: cook)) {
                    Text("Edit")
                }
                Text(cook.name)
                Text(cook.type)
                Text(cook.weight)
                Text("\(cook.date, formatter: self.dateFormatter)")
            }
        //}
    }
}

/*
#if DEBUG
struct CookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CookDetailView()
    }
}
#endif
*/
