//
//  PrismPriceCalculatorApp.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import SwiftUI

@main
struct PrismPriceCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView().environmentObject(AppState())
        }
    }
}
