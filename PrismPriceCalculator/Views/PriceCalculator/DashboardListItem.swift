//
//  DashboardListItem.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/13/22.
//

import SwiftUI

struct DashboardListItem: View {
    @State var businessServiceItem: BusinessService
    @State private var isShowingDetailView = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(
                url: URL(string: businessServiceItem.image),
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
            
            Text(businessServiceItem.description)
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
                    Text("৳\(businessServiceItem.startingPrice)")
                        .foregroundColor(Color("textColor3"))
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                Button(action: {
                    self.isShowingDetailView = true
                }) {
                    NavigationLink(destination: ServiceCustomizationView(), isActive: $isShowingDetailView) {
                        Text("View Pricing")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color("blue1"))
                            .padding(.horizontal, 15)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 5, style: .circular)
                                    .stroke(Color("blue1"), lineWidth: 1)
                            )
                    }//.isDetailLink(false)
                    
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
        DashboardListItem(businessServiceItem: BusinessService(image: "https://prismerp.rtchubs.com/img/prismerp.png",
                                          description: "An ERP System to cover all business needs designed for medium and large business",
                                          startingPrice: 2500000))
    }
}
