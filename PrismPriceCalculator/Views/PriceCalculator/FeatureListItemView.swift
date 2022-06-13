//
//  FeatureListItemView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/11/22.
//

import SwiftUI

struct FeatureListItemView: View {
    @State var feature: Feature
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            ZStack (alignment: .top) {
                Circle()
                    .fill(Color("green1"))
                    .frame(width: 15, height: 15)
                  Spacer()
                Rectangle()
                    .fill(Color("green1"))
                    .frame(width: 1)
                    //.alignmentGuide(VerticalAlignment.center) {   // << here !!
                      //  $0[VerticalAlignment.top]
                   // }
            }.padding(.leading, 37.5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(feature.name)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color("textColor3"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(feature.description ?? "")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(Color("textColor4"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                
            }.frame(maxWidth: .infinity)
            
            VStack(alignment: .center, spacing: 5) {
                Text("৳20,000")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("green1"))
                Text("LEARN MORE")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("textColor1"))
            }
            
            Button(action: {
                
            }) {
                Text("Add")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color("blue1")))
            }
            .padding(.trailing, 8)
            .padding(.top, 8)
        }.frame(maxWidth: .infinity, minHeight: 50)
    }
}

//struct FeatureListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeatureListItemView()
//    }
//}
