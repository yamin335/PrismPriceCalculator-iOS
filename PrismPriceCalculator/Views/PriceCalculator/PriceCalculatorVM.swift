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
        Module(code: "FMS-FA-FR",name: "Financial Reports", features: []),
        Module(code: "FMS-FA-AP",name: "Accounts Payable", features: []),
    ]),
    
    ModuleGroup(code: "CA", name: "Cost Accounting", modules: [
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
    ])
    // ...
]),

    PrismERP(code: "SDM", name: "Sales & Distribution Management", moduleGroups: [
    
    ModuleGroup(code: "SM", name: "Sales Management", modules: [
        Module(code: "FMS-FA-GL",name: "General Ledger", features: []),
        Module(code: "FMS-FA-FR",name: "Financial Reports", features: []),
        Module(code: "FMS-FA-AP",name: "Accounts Payable", features: []),
    ]),
    
    ModuleGroup(code: "SDM", name: "Sale Delivery Management", modules: [
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
    ])
    // ...
]),
    
    PrismERP(code: "CRM", name: "Customer Relationship Management", moduleGroups: [
    
    ModuleGroup(code: "SB", name: "Service Billing", modules: [
        Module(code: "FMS-FA-GL",name: "General Ledger", features: []),
        Module(code: "FMS-FA-FR",name: "Financial Reports", features: []),
        Module(code: "FMS-FA-AP",name: "Accounts Payable", features: []),
    ]),
    
    ModuleGroup(code: "SC", name: "Sales CRM", modules: [
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
    ])
    // ...
]),
    PrismERP(code: "SCM", name: "Supply Chain Management", moduleGroups: [
    
    ModuleGroup(code: "PBD", name: "Purchase Billing & Delivery", modules: [
        Module(code: "FMS-FA-GL",name: "General Ledger", features: []),
        Module(code: "FMS-FA-FR",name: "Financial Reports", features: []),
        Module(code: "FMS-FA-AP",name: "Accounts Payable", features: []),
    ]),
    
    ModuleGroup(code: "IWM", name: "Inventory and Warehouse Management", modules: [
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
        Module(code: "FMS-CA-CC",name: "Cost Centers", features: []),
    ])
    // ...
]),
    PrismERP(code: "HCM", name: "Human Capital Management", moduleGroups: [
    
    ModuleGroup(code: "EM", name: "Employee Management", modules: [
        Module(code: "FMS-FA-GL",name: "General Ledger", features: []),
        Module(code: "FMS-FA-FR",name: "Financial Reports", features: []),
        Module(code: "FMS-FA-AP",name: "Accounts Payable", features: []),
    ]),
    
    ModuleGroup(code: "MCM", name: "Manpower & Cost Management", modules: [
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
