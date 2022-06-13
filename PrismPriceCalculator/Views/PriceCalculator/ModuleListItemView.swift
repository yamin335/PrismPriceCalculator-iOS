//
//  ModuleListItemView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/10/22.
//

import SwiftUI

struct ModuleListItemView: View {
    @State var module: Module
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(module.name.toShortForm())
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background(RoundedRectangle(cornerRadius: 4, style: .circular).fill(Color("green1")))
                        .padding(.leading, 15)
                    Rectangle().fill(Color("green1"))
                        .frame(width: 1)
                        .padding(.leading, 45)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(module.name)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color("textColor3"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(module.description ?? "")
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
            }.frame(maxWidth: .infinity, minHeight: 70)
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(module.submodules, id: \.id) { subModule in
                    SubModuleListItemView(subModule: subModule)
                }
                
                ForEach(module.features, id: \.id) { feature in
                    FeatureListItemView(feature: feature)
                }
            }
        }
    }
}

//struct ModuleListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModuleListItemView()
//    }
//}
