//
//  HeaderCSC.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct HeaderCSC: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Users")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)

//            ChipGroup(chips: viewModel.users, selectedItemIndex: 0)
//                .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct HeaderCSC_Previews: PreviewProvider {
    static var previews: some View {
        HeaderCSC(viewModel: PriceCalculatorVM())
    }
}
