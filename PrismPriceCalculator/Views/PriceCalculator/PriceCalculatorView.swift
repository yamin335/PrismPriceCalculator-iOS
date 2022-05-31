//
//  PriceCalculatorView.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import SwiftUI

struct ModuleRowView: View {
    var module: Module

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(module.name)
                .foregroundColor(.primary)
                .font(.headline)
            HStack(spacing: 3) {
                Label(module.code, systemImage: "phone")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}


struct ModuleDetailView: View {
    var module: Module

    var body: some View {
        VStack {
            Text(module.name)
                .foregroundColor(.primary)
                .font(.title)
                .padding()
            HStack {
                Label(module.code, systemImage: "phone")
            }
            .foregroundColor(.secondary)
        }
    }
}
struct PriceCalculatorView: View {
    
     let fms = prismerps.last!
    
       var body: some View {
           NavigationView {
               List {
                   ForEach(fms.moduleGroups) { moduleGroups in
                       Section(header: Text(moduleGroups.name)) {
                           ForEach(moduleGroups.modules, id: \.id) { module in
                                   ModuleRowView(module: module)
                           }
                       }
                   }
               }
               .navigationTitle(fms.name)

               // Placeholder
               Text("No Selection")
                   .font(.headline)
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PriceCalculatorView()
    }
}
