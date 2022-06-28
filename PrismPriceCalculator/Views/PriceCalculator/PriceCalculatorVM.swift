//
//  PriceCalculatorVM.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation
import Combine

class PriceCalculatorVM: NSObject, ObservableObject {
    var baseModuleListPublisher = PassthroughSubject<[ServiceModule], Never>()
    var shouldCalculateData = PassthroughSubject<Bool, Never>()
    var calculateSelectedModuleFor = PassthroughSubject<String, Never>()
    var branches = [
        ChipsDataModel(label: "1 - 1", isSelected: true),
        ChipsDataModel(label: "2 - 4", isSelected: false),
        ChipsDataModel(label: "5 - 8", isSelected: false),
        ChipsDataModel(label: "Custom", isSelected: false)
    ]
    
    var products = [
        ChipsDataModel(label: "1 - 100", isSelected: true),
        ChipsDataModel(label: "101 - 500", isSelected: false),
        ChipsDataModel(label: "501 - 1500", isSelected: false)
    ]
    
    var businessType = [
        ChipsDataModel(label: "Manufacturing", isSelected: true),
        ChipsDataModel(label: "Trading", isSelected: false),
        ChipsDataModel(label: "Service", isSelected: false),
        ChipsDataModel(label: "Mixed", isSelected: false)
    ]
    
    func loadAllModuleData() {
        guard let url = Bundle.main.url(forResource: "divine", withExtension: "json") else {
            print("Json file not found")
            return
        }
        
        guard let data = try? Data(contentsOf: url),
        let list = try? JSONDecoder().decode([ServiceModule].self, from: data) else {
            print("Json file parsing failed!")
            return
        }
        
        var baseModuleList = list
        
        for baseModuleIndex in 0..<baseModuleList.count {
            for moduleGroupIndex in 0..<baseModuleList[baseModuleIndex].moduleGroups.count {
                baseModuleList[baseModuleIndex].moduleGroups[moduleGroupIndex].numberOfSelectedModule = 0
            }
        }
        baseModuleListPublisher.send(baseModuleList)
    }
}
