//
//  DashboardListItem.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/13/22.
//

import SwiftUI

struct DashboardListItem: View {
    var product: ServiceProduct
    @State private var selectedTag: Int? = -1
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            NavigationLink(destination: ServiceCustomizationView(productId: product.id ?? ""), tag: 1, selection: self.$selectedTag) {
                EmptyView()
            }.isDetailLink(false)
            AsyncImage(
                url: URL(string: "\(NetworkUtils.baseUrl)/\(product.logo ?? "")"),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }, placeholder: {
                    Color("gray1")
                })
                .frame(height: 40)
                .padding(.horizontal, 12)
                .padding(.top, 12)
//              .mask(
//                RoundedRectangle(cornerRadius: 16)
//                    .frame(width: .infinity, alignment: .leading)
//              )
            
            Text(product.description ?? "")
                .foregroundColor(Color("textColor2"))
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            
            Divider()
            
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("STARTING FROM")
                        .foregroundColor(Color("textColor4"))
                        .font(.system(size: 12))
                    Text("৳\(product.price ?? 0)")
                        .foregroundColor(Color("textColor3"))
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                Button(action: {
                    self.selectedTag = 1
                }) {
                    Text("View Pricing")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color("blue1"))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .stroke(Color("blue1"), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        
        .background(.white)
        .clipped()
        .cornerRadius(5)
        .shadow(color: Color("shadowColor"), radius: 5)
        .padding(.horizontal, 16)
    }
}

struct DashboardListItem_Previews: PreviewProvider {
    static var previews: some View {
        DashboardListItem(product: ServiceProduct(id: "prismerp", name: "PrismERP", logo: "prismerp.png", title: "An ERP System to cover all business needs designed for medium and large business", description: "An ERP System to cover all business needs designed for medium and large business", sheetlink: " https://docs.google.com/spreadsheets/d/e/2PACX-1vTX1GAAhTy2wXRTEgweR9hJj8FllG2h1N_zgYgfUf5iRx37XfbapHcuOz_wB0NA2L-XSZxhKKifatUK/pub?output=xlsx", productdetailslink: "https://store.divineit.net/prismerp/", isactive: true, price: 2500000, Table: ""))
    }
}
