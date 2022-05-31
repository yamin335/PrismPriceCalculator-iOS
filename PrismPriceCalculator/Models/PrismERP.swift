//
//  ListModel.swift
//  itsgood
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation

struct Module: Identifiable {
    let id = UUID()
    var code: String
    var name: String
    var features: [Person]
}

struct ModuleGroup: Identifiable {
    let id = UUID()
    var code: String
    var name: String
    var modules: [Module]
}

struct PrismERP: Identifiable {
    let id = UUID()
    var code: String
    var name: String
    var moduleGroups: [ModuleGroup]
}
