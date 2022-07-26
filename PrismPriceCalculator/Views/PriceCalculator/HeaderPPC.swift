//
//  HeaderPPC.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct HeaderPPC: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Industry Type")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)

//            ChipGroup(chips: viewModel.industryType, selectedItemIndex: 0)
//                .padding(.leading, 10)

            Text("Production Units")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

//            ChipGroup(chips: viewModel.productionUnits, selectedItemIndex: 0)
//                .padding(.leading, 10)

            Text("Line/Machine")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

//            ChipGroup(chips: viewModel.lineOrMachine, selectedItemIndex: 0)
//                .padding(.leading, 10)
            
            Text("Type of Finished Goods")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

//            ChipGroup(chips: viewModel.typeOfFinishedGoods, selectedItemIndex: 0)
//                .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct HeaderPPC_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPPC(viewModel: PriceCalculatorVM())
    }
}
