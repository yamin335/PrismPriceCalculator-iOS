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
