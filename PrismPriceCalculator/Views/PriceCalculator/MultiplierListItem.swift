//
//  MultiplierListItem.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct MultiplierListItem: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @State var multiplier: MultiplierClass
    @State var selectedItemIndex: Int = 0
    @State var chips: [ChipsDataModel] = []
    @State var showChipGroup: Bool = false
    @State var showSlider: Bool = false
    @State var sliderRange = 0.0
    @State var sliderStepSize = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(multiplier.label)
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            if showChipGroup {
                ChipGroup(chips: self.chips, selectedItemIndex: $selectedItemIndex)
                    .padding(.leading, 10)
            }
            
            if showSlider {
                SliderItem(sliderRange: sliderRange, increment: sliderStepSize)
            }
            
            Spacer()
        }.onAppear {
            prepareChipList()
        }
    }
    
    private func prepareChipList() {
        if multiplier.slabConfig.inputType == "slider" {
            if multiplier.slabs.isEmpty {
                return
            }
            switch multiplier.slabs[0] {
            case .integer(let range):
                sliderRange = Double(range)
                switch multiplier.slabConfig.increment {
                case .integer(let increment):
                    sliderStepSize = Double(increment)
                    showSlider = true
                case .string(let val):
                    print(val)
                }
            case .string(let t):
                print(t)
            }
        } else {
            showSlider = false
            var chips: [ChipsDataModel] = []
            for (index, item) in multiplier.slabs.enumerated() {
                switch item {
                case .integer(let i):
                    let slabText = multiplier.slabConfig.slabTexts[index].title ?? ""
                    switch multiplier.slabConfig.increment {
                    case .integer(let increment):
                        var startItem = increment
                        if index > 0 {
                            switch multiplier.slabs[index-1] {
                            case .integer(let previousItem):
                                startItem = previousItem + increment
                            case .string(let temp):
                                print(temp)
                            }
                            
                        }
                        
                        let chipItem: ChipsDataModel = ChipsDataModel(label: slabText.isEmpty ? "\(startItem)-\(i)" : "\(slabText)(\(startItem)-\(i))")
                        chips.append(chipItem)
                    case .string( _):
                        let chipItem: ChipsDataModel = ChipsDataModel(label: "\(i)")
                        chips.append(chipItem)
                    }
                        
                    
                    
                case .string(let j):
                    let chipItem: ChipsDataModel = ChipsDataModel(label: j)
                    chips.append(chipItem)
                    
                }
            }
            self.chips = chips
            if !self.chips.isEmpty {
                showChipGroup = true
            }
        }
    }
}

//struct MultiplierListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiplierListItem(viewModel: PriceCalculatorVM(), label: "Test")
//    }
//}
