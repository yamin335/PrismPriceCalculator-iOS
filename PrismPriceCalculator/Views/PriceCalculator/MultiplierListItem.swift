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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(multiplier.label ?? "")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            if showChipGroup {
                ChipGroup(chips: self.chips, selectedItemIndex: $selectedItemIndex)
                    .padding(.leading, 10)
            }
            
            if showSlider {
                SliderItem(sliderRange: sliderRange, increment: sliderStepSize, sliderValue: $sliderValue)
            }
            
            Spacer()
        }.onAppear {
            selectedItemIndex = multiplier.slabIndex ?? 0
            prepareChipList()
        }.onChange(of: selectedItemIndex) { newValue in
            multiplier.slabIndex = newValue
            viewModel.selectedMultiplierPublisher.send((multiplier.code ?? "", newValue))
            self.viewModel.shouldCalculateData.send(true)
        }.onChange(of: sliderValue) { newValue in
            viewModel.sliderValuePublisher.send((multiplier.code ?? "", Int(newValue)))
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
                    let slabText = multiplier.slabTexts.count > index ? multiplier.slabTexts[index] : ""
                    let increment = multiplier.slabConfig?.increment ?? 0
                    
                    let itemValue = Int(Double(item) ?? 0.0)
                    
                    var startItem = increment
                    if index > 0 {
                        startItem = Int(Double(multiplier.slabs[index-1]) ?? 0.0) + increment
                    }
                    
                    let chipItem: ChipsDataModel = ChipsDataModel(label: slabText.isEmpty ? startItem == itemValue ? "\(itemValue)" : "\(startItem)-\(itemValue)" : startItem == itemValue ? "\(slabText)(\(itemValue))" : "\(slabText)(\(startItem)-\(itemValue))")
                    chips.append(chipItem)
                } else {
                    let chipItem: ChipsDataModel = ChipsDataModel(label: item)
                    chips.append(chipItem)
                }
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
