//
//  PriceCalculatorVM.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation

var prismerps: [PrismERP] = [
    
    PrismERP(code: "START", name: "Welcome to PrismERP Pricing System", moduleGroups: [
    
    ModuleGroup(code: "GS", name: "Getting Started", modules: [
        Module(code: "START-GS-1.0",name: "Introduction", features: []),
    ]),
]),
    

                  
    PrismERP(code: "FMS", name: "Financial Management System", moduleGroups: [
    
    ModuleGroup(code: "FA", name: "Financial Accounting", modules: [
        Module(code: "FMS-FA-GL",name: "General Ledger", features: []),
        Module(code: "FMS-FA-GL",name: "General Ledger", features: []),
        Module(code: "FMS-FA-GL",name: "General Ledger", features: []),
    ]),
                
    ModuleGroup(code: "CA", name: "Cost Accounting", modules: [
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
    ])
    // ...
])


]


struct Person: Identifiable {
     let id = UUID()
     var name: String
     var phoneNumber: String
 }

var staff = [
    Person(name: "Juan Chavez", phoneNumber: "(408) 555-4301"),
    Person(name: "Mei Chen", phoneNumber: "(919) 555-2481")
]
