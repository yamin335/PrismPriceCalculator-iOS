//
//  MultiplierListItem.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct MultiplierListItem: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @Binding var multiplier: MultiplierClass
    @State var selectedItemIndex: Int = 0
    @State var chips: [ChipsDataModel] = []
    @State var showChipGroup: Bool = false
    @State var showSlider: Bool = false
    @State var sliderRange = 0.0
    @State var sliderStepSize = 0.0
    @State var sliderValue: Double = 0
    @State var customValue: String = ""
    @State var isCustomSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(multiplier.label ?? "")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            if showChipGroup {
                ChipGroup(chips: self.chips, selectedItemIndex: $selectedItemIndex, isCustomSelected: $isCustomSelected)
                    .padding(.leading, 10)
            }
            
            if showSlider {
                SliderItem(sliderRange: sliderRange, increment: sliderStepSize, sliderValue: $sliderValue)
            }
            
            if isCustomSelected {
                TextField("Custom Value", text: $customValue)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
            }
            
            Spacer()
        }.onAppear {
            if let customValue = multiplier.customValue, !customValue.isEmpty {
                self.customValue = multiplier.customValue ?? ""
                self.isCustomSelected = true
                selectedItemIndex = -1
            } else {
                selectedItemIndex = multiplier.slabIndex ?? 0
                self.isCustomSelected = false
            }
            
            prepareChipList()
        }.onChange(of: selectedItemIndex) { newValue in
            if newValue != -1 {
                self.customValue = ""
                multiplier.customValue = self.customValue
                multiplier.slabIndex = newValue
                viewModel.selectedMultiplierPublisher.send((multiplier.code ?? "", newValue, ""))
                self.viewModel.shouldCalculateData.send(true)
            }
        }.onChange(of: sliderValue) { newValue in
            viewModel.sliderValuePublisher.send((multiplier.code ?? "", Int(newValue)))
        }.onChange(of: customValue) { newValue in
            multiplier.customValue = newValue
            viewModel.selectedMultiplierPublisher.send((multiplier.code ?? "", -1, newValue))
            self.viewModel.shouldCalculateData.send(true)
        }
    }
    
    private func prepareChipList() {
        if multiplier.slabConfig?.inputType == "slider" {
//            if multiplier.slabs.isEmpty {
//                return
//            }
            
            sliderRange = 50
            sliderStepSize = 1
            showSlider = true
            
//            switch multiplier.slabs[0] {
//            case .integer(let range):
//
//                switch multiplier.slabConfig.increment {
//                case .integer(let increment):
//
//                case .string(let val):
//                    print(val)
//                }
//            case .string(let t):
//                print(t)
//            }
        } else {
            showSlider = false
            var chips: [ChipsDataModel] = []
            for (index, item) in multiplier.slabs.enumerated() {
                let regex = NSRegularExpression(#"^[0-9]+(?:[.,][0-9]+)*$"#)
                let isNumber = regex.matches(in: item)
                
                if isNumber {
                    if multiplier.slabConfig?.showRange == true {
                        let slabText = multiplier.slabTexts.count > index ? multiplier.slabTexts[index] : ""
                        let increment = 1
                        
                        let itemValue = Int(Double(item) ?? 0.0)
                        
                        var startItem = increment
                        if index > 0 {
                            startItem = Int(Double(multiplier.slabs[index-1]) ?? 0.0) + increment
                        }
                        
                        let chipItem: ChipsDataModel = ChipsDataModel(label: slabText.isEmpty ? "\(startItem)-\(itemValue)" : "\(slabText)(\(startItem)-\(itemValue))")
                        chips.append(chipItem)
                    } else {
                        let slabText = multiplier.slabTexts.count > index ? multiplier.slabTexts[index] : ""
                        
                        let itemValue = Int(Double(item) ?? 0.0)
                        
                        let chipItem: ChipsDataModel = ChipsDataModel(label: slabText.isEmpty ? "\(itemValue)" : "\(slabText)(\(itemValue))")
                        chips.append(chipItem)
                    }
                } else {
                    let chipItem: ChipsDataModel = ChipsDataModel(label: item)
                    chips.append(chipItem)
                }
            }
            
            if multiplier.slabConfig?.customUser == true {
                chips.append(ChipsDataModel(label:  AppConstants.labelCustom))
            }
            
            self.chips = chips
            
            if !self.chips.isEmpty {
                showChipGroup = true
            } else {
                showChipGroup = false
            }
        }
    }
}

//struct MultiplierListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiplierListItem(viewModel: PriceCalculatorVM(), label: "Test")
//    }
//}
