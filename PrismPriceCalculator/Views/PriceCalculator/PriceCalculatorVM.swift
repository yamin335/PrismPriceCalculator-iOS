//
//  PriceCalculatorVM.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation
import Combine

class PriceCalculatorVM: NSObject, ObservableObject {
    var baseModuleList = PassthroughSubject<[BaseServiceModule], Never>()
    
    func loadAllModuleData() {
        guard let url = Bundle.main.url(forResource: "divine", withExtension: "json") else {
            print("Json file not found")
            return
        }
        
        guard let data = try? Data(contentsOf: url),
        let moduleList = try? JSONDecoder().decode([BaseServiceModule].self, from: data) else {
            print("Json file parsing failed!")
            return
        }
        baseModuleList.send(moduleList)
    }
}
