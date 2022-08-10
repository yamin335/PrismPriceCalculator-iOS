//
//  ListModel.swift
//  itsgood
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation
import SwiftUI

struct ServiceModuleResponse: Codable {
    let code: Int?
    let data: ServiceModuleResponseData?
    let msg: String?
    
    enum CodingKeys: String, CodingKey {
        case code, data, msg
    }
}

struct ServiceModuleResponseData: Codable {
    let Modules: [BaseServiceModule]?
    
    enum CodingKeys: String, CodingKey {
        case Modules
    }
}

struct BaseServiceModule: Codable, Identifiable {
    let id = UUID()
    let code: String?
    let name: String?
    let moduleGroups: [ModuleGroup]
    var multipliers: [MultiplierClass]
    
    enum CodingKeys: String, CodingKey {
        case id, code, name, moduleGroups, multipliers
    }
}

struct ModuleGroup: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let code: String?
    let ModuleStartIndex: Int?
    let ModuleEndIndex: Int?
    let modules: [ServiceModule]
    let dependencies: [String?]
    let showMultiplier: String?
    let description: String?
    var numberOfSelectedModule: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case name, code, ModuleStartIndex, ModuleEndIndex, modules, dependencies, showMultiplier, description, numberOfSelectedModule
    }
}

struct ServiceModule: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let code: String?
    let description: String?
    let selfCode: String?
    let totalamount: Int?
    let discount: Int?
    let features: [Feature]
    let dependencies: [String]
    let multiplier: String?
    let price: [String]
    let excludeInAll: Bool?
    var defaultprice: Double = 0.0
    var isAdded: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case name, code, description, selfCode, totalamount, discount, features, dependencies, multiplier, price, excludeInAll, defaultprice, isAdded
    }
}

struct Feature: Codable, Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let parentcode: String?
    let description: String?
    let multipliercode: String?
    let type: String?
    let excludeInAll: Bool?
    let discount: Int?
    let multiplier: String?
    let price: [String]
    var isAdded: Bool = false
    var defaultprice: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case name, code, parentcode, description, multipliercode, type, excludeInAll, discount, multiplier, price, isAdded, defaultprice
    }
}

struct MultiplierClass: Codable, Identifiable {
    let id = UUID()
    let name: String?
    let code: String?
    let label: String?
    let slabConfig: SlabConfig?
    let slabs: [String]
    let slabTexts: [String]
    var slabIndex: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case name, code, label, slabConfig, slabs, slabTexts, slabIndex
    }
}

struct SlabConfig: Codable {
    let inputType: String?
    let showSlabs: Bool?
    let className: String?
    let hideInApp: Bool?
    let showRange: Bool?
    let customUser: Bool?
    let help: String?
    let increment: Int?
}

struct ModuleGroupSummary {
    let code: String
    let title: String
    let price: Int
}

struct SummaryItem {
    let id = UUID()
    let title: String
    let price: Int
}

//struct ServiceModule: Codable Identifiable {
//    let id = UUID{}
//    let code: String
//    let name: String
//    var moduleGroups: [ModuleGroup]
//
//    enum CodingKeys: String CodingKey {
//        case code name moduleGroups
//    }
//}
//
//struct ModuleGroup: Codable Identifiable {
//    let id = UUID{}
//    let name: String
//    let code: String
//    var modules: [Module]
//    var multipliers: [MultiplierClass]
//    let showMultiplier: String?
//    let description: String?
//    var numberOfSelectedModule: Int? = 0
//
//    enum CodingKeys: String CodingKey {
//        case name code modules multipliers showMultiplier description numberOfSelectedModule
//    }
//}
//
//struct Module: Codable Identifiable {
//    let id = UUID{}
//    let code: String
//    let selfCode: String
//    let name: String
//    var submodules: [SubModule]
//    var features: [Feature]
//    let description: String?
//    let dependencies: [String]
//    var slabPrice: Int? = 0
//    let price: Price?
//    let ready: String?
//    let showMultiplier: String?
//    var isAdded: Bool? = false
//
//    enum CodingKeys: String CodingKey {
//        case code selfCode name submodules features description dependencies slabPrice price ready showMultiplier isAdded
//    }
//}
//
//struct Feature: Codable Identifiable {
//    let id = UUID{}
//    let name: String
//    let code: String
//    let description: String?
//    var slabPrice: Int? = 0
//    let price: Price?
//    let ready: String?
//    let excludeInAll: Int32?
//    var isAdded: Bool? = false
//
//    enum CodingKeys: String CodingKey {
//        case name code description slabPrice price ready excludeInAll isAdded
//    }
//}
//
//struct SubModule: Codable Identifiable {
//    let id = UUID{}
//    let name: String
//    let code: String
//    var features: [Feature]
//    let description: String?
//    let price: Price?
//
//    enum CodingKeys: String CodingKey {
//        case name code features description price
//    }
//}
//
//struct MultiplierClass: Codable Identifiable {
//    let id = UUID{}
//    let code: String
//    let label: String
//    var slabIndex: Int? = 0
//    let slabConfig: SlabConfig
//    let slabs: [IntOrStringElement] // Can be long or string type
//    let name: String
//
//    enum CodingKeys: String CodingKey {
//        case code label slabConfig slabs name
//    }
//}
//
//struct SlabConfig: Codable {
//    let type: String?
//    let customUser: Bool
//    let slabRange: Bool
//    let hideInApp: Bool?
//    let inputType: String
//    let showSlabs: Bool
//    let increment: IntOrStringElement
//    let slabTexts: [SlabText]
//    let className: String?
//    let customText: String?
//    let showRange: Bool?
//    let help: String?
//    let noDefault: Bool?
//    let paramType: String?
//}
//
//struct SlabText: Codable Identifiable {
//    let id = UUID{}
//    let title: String?
//
//    enum CodingKeys: CodingKey {
//        case title
//    }
//}
//
//struct Price: Codable {
//    let multiplier: IntOrStringElement?
//    let slab1: IntOrStringElement?
//    let slab2: IntOrStringElement?
//    let slab3: IntOrStringElement?
//    let slab4: IntOrStringElement?
//    let slab5: IntOrStringElement?
//    let slab6: IntOrStringElement?
//    let slab7: IntOrStringElement?
//}
