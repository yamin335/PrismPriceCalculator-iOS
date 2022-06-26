//
//  ModuleListItemView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/10/22.
//

import SwiftUI

struct ModuleListItemView: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @Binding var module: Module
    @State var baseModuleCode: String
    @State var index: Int
    @State var price: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(baseModuleCode == "START" ? "\(Double(index) + 1.0)" : module.name.toShortForm())
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background(RoundedRectangle(cornerRadius: 4, style: .circular).fill(baseModuleCode == "START" ? Color("red1") : Color("green1")))
                        .padding(.leading, 15)
                    
                    if baseModuleCode != "START" {
                        Rectangle().fill(Color("green1"))
                            .frame(width: 1)
                            .padding(.leading, 45)
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(module.name)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("textColor3"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(module.description ?? "")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(Color("textColor4"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                }.frame(maxWidth: .infinity)
                
                if self.price > 0 {
                    VStack(alignment: .center, spacing: 5) {
                        Text("৳\(price)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color("green1"))
                        Text("LEARN MORE")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("textColor1"))
                    }
                    
                    Button(action: {
                        module.isAdded = !(module.isAdded ?? false)
                        if !(module.isAdded ?? false) {
                            for featureIndex in 0..<module.features.count {
                                module.features[featureIndex].isAdded = false
                            }
                            
                            for subModuleIndex in 0..<module.submodules.count {
                                for featureIndex in 0..<module.submodules[subModuleIndex].features.count {
                                    module.features[featureIndex].isAdded = false
                                }
                            }
                        }
                        self.viewModel.shouldCalculateData.send(true)
                    }) {
                        if module.isAdded == true {
                            Text("Remove")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color("green1")))
                        } else {
                            Text("Add")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color("blue1")))
                        }
                    }
                    .padding(.trailing, 8)
                    .padding(.top, 8)
                }
            }.frame(maxWidth: .infinity, minHeight: 70)
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach($module.submodules, id: \.id) { $subModule in
                    SubModuleListItemView(viewModel: viewModel, subModule: $subModule, module: $module)
                }
                
                ForEach($module.features, id: \.id) { $feature in
                    FeatureListItemView(viewModel: viewModel, feature: $feature, module: $module)
                }
            }
        }.onAppear {
            guard let slab1 = module.price?.slab1 else {
                return
            }
            
            switch slab1 {
            case .integer(let i):
                price = i
            case .string(let j):
                print(j)
            }
        }
    }
}

//struct ModuleListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModuleListItemView()
//    }
//}
