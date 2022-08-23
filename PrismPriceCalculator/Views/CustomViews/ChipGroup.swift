//
//  ChipGroup.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/28/22.
//

import SwiftUI

struct ChipGroup: View {
    @State var chips: [ChipsDataModel]
    @Binding var selectedItemIndex: Int
    @Binding var isCustomSelected: Bool
    @State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List //    = CGFloat.infinity   // << variant for VStack
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
            Spacer()
        }
        .frame(height: totalHeight) // << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(Array(chips.enumerated()), id: \.offset) { index, chipData in
                Button(action: {
                  withAnimation {
                      if chipData.label == AppConstants.labelCustom {
                          isCustomSelected = true
                          self.selectedItemIndex = -1
                      } else {
                          isCustomSelected = false
                          self.selectedItemIndex = index
                      }
                  }
                }) {
                    Text(chipData.label)
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(selectedItemIndex == -1 && chipData.label == AppConstants.labelCustom ? Color("blue1") : selectedItemIndex == index ? Color("blue1") : Color("gray3"))
                        .cornerRadius(40)
                }
                .padding(.vertical, 5)
                .padding(.trailing, 10)
                .alignmentGuide(.leading) { dimension in  //update leading width for available width
                    if (abs(width - dimension.width) > geometry.size.width) {
                        width = 0
                        height -= dimension.height
                    }
                    
                    let result = width
                    if chipData.id == chips.last!.id {
                        width = 0
                    } else {
                        width -= dimension.width
                    }
                    return result
                  }
                .alignmentGuide(.top) { dimension in //update chips height origin wrt past chip
                    let result = height
                    
                    if chipData.id == chips.last!.id {
                        height = 0
                    }
                    return result
                }
                .onTapGesture {
                    selectedItemIndex = index
                    //chips[selectedItemIndex].isSelected = true
                }
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

//struct ChipGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        ChipGroup(chips: [ChipsDataModel(label: "Selected", isSelected: true), ChipsDataModel(label: "Not Selected", isSelected: false)], selectedItemIndex: Binding(0))
//    }
//}
