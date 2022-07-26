//
//  FeatureListItemView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/11/22.
//

import SwiftUI

struct FeatureListItemView: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @Binding var moduleGroup: ModuleGroup
    @Binding var feature: Feature
    @Binding var module: Module
    @State var price: Int = 0
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            ZStack (alignment: .top) {
                Circle()
                    .fill(Color("green1"))
                    .frame(width: 15, height: 15)
                  Spacer()
                Rectangle()
                    .fill(Color("green1"))
                    .frame(width: 1)
                    //.alignmentGuide(VerticalAlignment.center) {   // << here !!
                      //  $0[VerticalAlignment.top]
                   // }
            }.padding(.leading, 37.5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(feature.name)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color("textColor3"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(feature.description ?? "")
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
                    var isFeatureAdded = feature.isAdded ?? false
                    feature.isAdded = !isFeatureAdded
                    
                    isFeatureAdded = feature.isAdded ?? false
                    
                    let isModuleAdded = module.isAdded ?? false
                    if isFeatureAdded && !isModuleAdded {
                        module.isAdded = true
                        if let numberOfSelectedModule = moduleGroup.numberOfSelectedModule {
                            moduleGroup.numberOfSelectedModule = numberOfSelectedModule + 1
                        }
                    }
                    self.viewModel.shouldCalculateData.send(true)
                }) {
                    if feature.isAdded == true {
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
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .onAppear {
            if feature.slabPrice == nil || feature.slabPrice == 0 {
                guard let slab1 = feature.price?.slab1 else {
                    return
                }
                
                switch slab1 {
                case .integer(let i):
                    setPrice(with: i)
                case .string(let j):
                    print(j)
                }
            } else {
                price = feature.slabPrice ?? 0
            }
        }.onReceive(self.viewModel.selectedMultiplierPublisher.receive(on: RunLoop.main)) { pair in
            guard let multiplierCode = feature.price?.multiplier else {
                return
            }
            
            switch multiplierCode {
            case .integer(let intValue):
                print(intValue)
            case .string(let stringValue):
                if pair.0 == stringValue {
                    calculatePrice(with: pair.1)
                }
            }
        }
    }
    
    private func setPrice(with value: Int) {
        price = value
        feature.slabPrice = value
    }
    
    private func calculatePrice(with index: Int) {
        switch index {
        case 0:
            guard let slab1 = feature.price?.slab1 else {
                return
            }
            
            switch slab1 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        case 1:
            guard let slab2 = feature.price?.slab2 else {
                return
            }
            
            switch slab2 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        case 2:
            guard let slab3 = feature.price?.slab3 else {
                return
            }
            
            switch slab3 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        case 3:
            guard let slab4 = feature.price?.slab4 else {
                return
            }
            
            switch slab4 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        case 4:
            guard let slab5 = feature.price?.slab5 else {
                return
            }
            
            switch slab5 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        case 5:
            guard let slab6 = feature.price?.slab6 else {
                return
            }
            
            switch slab6 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        case 6:
            guard let slab7 = feature.price?.slab7 else {
                return
            }
            
            switch slab7 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        default:
            guard let slab1 = feature.price?.slab1 else {
                return
            }
            
            switch slab1 {
            case .integer(let i):
                setPrice(with: i)
            case .string(let j):
                print(j)
            }
        }
    }
}

//struct FeatureListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeatureListItemView()
//    }
//}
