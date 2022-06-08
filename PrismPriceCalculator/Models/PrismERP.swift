//
//  ListModel.swift
//  itsgood
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation

struct BaseServiceModule: Codable, Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let moduleGroups: [ModuleGroup]
    
    enum CodingKeys: String, CodingKey {
        case code, name, moduleGroups
    }
}

struct ModuleGroup: Codable, Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let modules: [ServiceModule]
    let multipliers: [MultiplierClass]
    let showMultiplier: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name, code, modules, multipliers, showMultiplier, description
    }
}

struct ServiceModule: Codable, Identifiable {
    let id = UUID()
    let code: String
    let selfCode: String
    let name: String
    let submodules: [SubModule]
    let features: [Feature]
    let description: String?
    let dependencies: [String]
    let price: Price?
    let ready: String?
    let showMultiplier: String?
    
    enum CodingKeys: String, CodingKey {
        case code, selfCode, name, submodules, features, description, dependencies, price, ready, showMultiplier
    }
}

struct Feature: Codable, Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let description: String?
    let price: Price?
    let ready: String?
    let excludeInAll: Int32?
    
    enum CodingKeys: String, CodingKey {
        case name, code, description, price, ready, excludeInAll
    }
}

struct SubModule: Codable, Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let features: [Feature]?
    let description: String?
    let price: Price?
    
    enum CodingKeys: String, CodingKey {
        case name, code, features, description, price
    }
}

struct MultiplierClass: Codable, Identifiable {
    let id = UUID()
    let code: String
    let label: String
    let slabConfig: SlabConfig
    let slabs: [IntOrStringElement] // Can be long or string type
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case code, label, slabConfig, slabs, name
    }
}

struct SlabConfig: Codable {
    let type: String?
    let customUser: Bool
    let slabRange: Bool
    let hideInApp: Bool?
    let inputType: String
    let showSlabs: Bool
    let increment: IntOrStringElement
    let slabTexts: [SlabText]
    let className: String?
    let customText: String?
    let showRange: Bool?
    let help: String?
    let noDefault: Bool?
    let paramType: String?
}

struct SlabText: Codable, Identifiable {
    let id = UUID()
    let title: String?
    
    enum CodingKeys: CodingKey {
        case title
    }
}

struct Price: Codable {
    let multiplier: IntOrStringElement?
    let slab1: IntOrStringElement?
    let slab2: IntOrStringElement?
    let slab3: IntOrStringElement?
    let slab4: IntOrStringElement?
    let slab5: IntOrStringElement?
    let slab6: IntOrStringElement?
    let slab7: IntOrStringElement?
}

enum IntOrStringElement: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(IntOrStringElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for IntOrStringElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
