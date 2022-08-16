//
//  SubModuleListItemView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/11/22.
//

import Foundation
import SwiftUI

//struct SubModuleListItemView: View {
//    @ObservedObject var viewModel: PriceCalculatorVM
//    @Binding var moduleGroup: ModuleGroup
//    @Binding var subModule: SubModule
//    @Binding var module: Module
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            HStack(alignment: .top, spacing: 8) {
//                VStack(alignment: .leading, spacing: 0) {
//                    RoundedRectangle(cornerRadius: 4)
//                        .fill(Color("green1"))
//                        .frame(width: 36, height: 16)
//                        .padding(.leading, 24)
//                    Rectangle().fill(Color("green1"))
//                        .frame(width: 1).padding(.leading, 45)
//                }
//
//                VStack(alignment: .leading, spacing: 5) {
//                    Text(subModule.name)
//                        .font(.system(size: 14, weight: .regular))
//                        .foregroundColor(Color("textColor3"))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text(subModule.description ?? "")
//                        .font(.system(size: 11, weight: .regular))
//                        .foregroundColor(Color("textColor4"))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.bottom, 8)
//
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.trailing, 8)
//
//            }.frame(maxWidth: .infinity, minHeight: 50)
//
//            ForEach($subModule.features, id: \.id) { $feature in
//                FeatureListItemView(viewModel: viewModel, moduleGroup: $moduleGroup, feature: $feature, module: $module)
//            }
//        }
//    }
//}
