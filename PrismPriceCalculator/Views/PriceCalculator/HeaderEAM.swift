//
//  HeaderEAM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct HeaderEAM: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Serials")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)

//            ChipGroup(chips: viewModel.serials, selectedItemIndex: 0)
//                .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct HeaderEAM_Previews: PreviewProvider {
    static var previews: some View {
        HeaderEAM(viewModel: PriceCalculatorVM())
    }
}
