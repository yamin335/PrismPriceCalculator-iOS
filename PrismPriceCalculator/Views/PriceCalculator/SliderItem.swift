//
//  SliderItem.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/26/22.
//

import SwiftUI

struct SliderItem: View {
    let sliderRange: Double
    let increment: Double
    @Binding var sliderValue: Double
    
    var body: some View {
        HStack {
            Text("STD(0)")
                .font(.system(size: 15))
                .foregroundColor(Color("textColor2"))
                .padding(.leading, 10)
            
            Slider(value: $sliderValue, in: 0...sliderRange, step: increment)
            
            Text("MAX(\(sliderRange))")
                .font(.system(size: 15))
                .foregroundColor(Color("textColor2"))
                .padding(.trailing, 10)
        }
    }
}

//struct SliderItem_Previews: PreviewProvider {
//    static var previews: some View {
//        SliderItem(sliderRange: 50, increment: 1)
//    }
//}
