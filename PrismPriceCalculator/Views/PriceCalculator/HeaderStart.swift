//
//  HeaderStart.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/28/22.
//

import SwiftUI

struct HeaderStart: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Branches")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)

            ChipGroup(chips: viewModel.branches, selectedItemIndex: 0)
                .padding(.leading, 10)

            Text("Products")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

            ChipGroup(chips: viewModel.products, selectedItemIndex: 0)
                .padding(.leading, 10)

            Text("Business Type")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

            ChipGroup(chips: viewModel.businessType, selectedItemIndex: 0)
                .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct HeaderStart_Previews: PreviewProvider {
    static var previews: some View {
        HeaderStart(viewModel: PriceCalculatorVM())
    }
}
