//
//  BaseModuleHeaderView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/28/22.
//

import SwiftUI

struct BaseModuleHeaderView: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @State var baseModuleCode: String
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                Text("Licensing Parameters")
                    .foregroundColor(Color("textColor1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    withAnimation {
                    }
                }) {
                    Text("Save Changes")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color("blue1")))
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            Divider().padding(.horizontal, 10)
            if baseModuleCode == "START" {
                HeaderStart(viewModel: viewModel)
            }
        }
        .background(RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color("blue1"), lineWidth: 1))
    }
}

struct BaseModuleHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BaseModuleHeaderView(viewModel: PriceCalculatorVM(), baseModuleCode: "START")
    }
}
