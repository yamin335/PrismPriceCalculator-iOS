//
//  MultiplierListItem.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct MultiplierListItem: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @State var label: String
    @State private var value: Double = 25
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label)
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            HStack {
                Text("STD(0)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.leading, 10)
                
                Slider(value: $value, in: 0...50, step: 1)
                
                Text("MAX(50)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.trailing, 10)
            }
            Spacer()
        }
    }
}

struct MultiplierListItem_Previews: PreviewProvider {
    static var previews: some View {
        MultiplierListItem(viewModel: PriceCalculatorVM(), label: "Test")
    }
}
