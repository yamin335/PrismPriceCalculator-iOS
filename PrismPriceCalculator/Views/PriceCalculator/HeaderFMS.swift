//
//  HeaderFMS.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct HeaderFMS: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Accounts")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)

            ChipGroup(chips: viewModel.accounts, selectedItemIndex: 0)
                .padding(.leading, 10)

            Text("Customers")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

            ChipGroup(chips: viewModel.customers, selectedItemIndex: 0)
                .padding(.leading, 10)

            Text("Vendors")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

            ChipGroup(chips: viewModel.vendors, selectedItemIndex: 0)
                .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct HeaderFMS_Previews: PreviewProvider {
    static var previews: some View {
        HeaderFMS(viewModel: PriceCalculatorVM())
    }
}
