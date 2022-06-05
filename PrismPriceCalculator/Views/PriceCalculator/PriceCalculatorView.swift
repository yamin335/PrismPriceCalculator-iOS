//
//  PriceCalculatorView.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import SwiftUI

struct ModuleRowView: View {
    var module: Module

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(module.name)
                .foregroundColor(.primary)
                .font(.headline)
            HStack(spacing: 3) {
                Label(module.code, systemImage: "phone")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}

struct ModuleHeaderView: View {
    var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text(moduleGroup.name)
                    .foregroundColor(Color("textColor2"))
                    .font(.headline)
                Text("11 modules")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .medium))
                    .frame(height: 20)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("blue1")))
                Text(isExpanded ? "Click to hide Modules" : "Click to show Modules")
                    .foregroundColor(Color("blue1"))
                    .font(.system(size: 10))
                Spacer()
            }
            Spacer()
            VStack(spacing: 6) {
                HStack(spacing: 5) {
                    Image("ic_select_all")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                    Image("ic_add_circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                    Image("is_toggle_selection")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                    Image("ic_clear_circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                }
                Text("No module selected")
                    .foregroundColor(.black)
                    .font(.system(size: 11, weight: .medium))
                    .frame(height: 24)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 12, style: .circular).fill(Color("yellow1")))
                Spacer()
            }
        }
    }
}

struct ModuleDetailView: View {
    var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool

    var body: some View {
        if isExpanded {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(moduleGroup.modules, id: \.id) { module in
                        ModuleRowView(module: module)
                }
            }
        }
    }
}

struct ModuleItemView: View {
    @State var isExpanded: Bool = false
    var moduleGroup: ModuleGroup
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ModuleHeaderView(moduleGroup: moduleGroup, isExpanded: $isExpanded)
                .onTapGesture {
                    withAnimation {
                        isExpanded = !isExpanded
                    }
                }
            ModuleDetailView(moduleGroup: moduleGroup, isExpanded: self.$isExpanded)
        }
    }
}

struct PriceCalculatorView: View {
    
     let fms = prismerps.last!
    @State private var bottomSheetShown = false
    @State private var showSideMenu = false
       var body: some View {
           GeometryReader { geometry in
           NavigationView {
//               List {
//                   ForEach(fms.moduleGroups) { moduleGroups in
//
//                       Section {
//                           ForEach(moduleGroups.modules, id: \.id) { module in
//                                   ModuleRowView(module: module)
//                           }
//                       } header: {
//                           ModuleHeaderView(moduleGroup: moduleGroups)
//                       }
//                   }
//
//
//               }.listStyle(PlainListStyle())
//
//               .navigationTitle(fms.code)
               ScrollView {
                   ForEach(fms.moduleGroups) { moduleGroup in
                       ModuleItemView(moduleGroup: moduleGroup)
                           .padding(.leading, 10)
                           .padding(.trailing, 10)
                           .padding(.top, 10)
                           .padding(.bottom, 10)
                           .overlay (
                        RoundedRectangle(cornerRadius: 5, style: .circular)
                            .stroke(Color("gray4"), lineWidth: 0.8)
                    )
                   }
               }
               .padding(.leading, 10)
               .padding(.trailing, 10)
               
               .navigationTitle(fms.code)

               .navigationBarItems(trailing: (
                   Button(action: {
                       withAnimation {
                           self.showSideMenu.toggle()
                       }
                   }) {
                       Image(systemName: "line.horizontal.3")
                           .imageScale(.large)
                   }
               ))
           }.sideMenu(isShowing: $showSideMenu) {
               VStack(alignment: .leading) {
                 Button(action: {
                   withAnimation {
                     self.showSideMenu = false
                   }
                 }) {
                   HStack {
                     Image(systemName: "xmark")
                       .foregroundColor(.white)
                     Text("close menu")
                   
                       .font(.system(size: 14))
                       .padding(.leading, 15.0)
                   }
                 }.padding(.top, 20)
                   Divider()
                       .frame(height: 20)
                   List {
                       ForEach(prismerps) { moduleGroup in
                           Button(action: {
                             withAnimation {
                               self.showSideMenu = false
                             }
                           }) {
                           Text(moduleGroup.code)
                           }
                       }
                   }
                  Spacer()
                }.padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
               
           }
               BottomSheetView(
                              isOpen: self.$bottomSheetShown,
                              maxHeight: geometry.size.height * 0.85
                          ) {
                              ScrollView {
                                  ForEach(fms.moduleGroups) { moduleGroup in
                                      ModuleItemView(moduleGroup: moduleGroup)
                                          .padding(.leading, 10)
                                          .padding(.trailing, 10)
                                          .padding(.top, 10)
                                          .padding(.bottom, 10)
                                          .overlay (
                                       RoundedRectangle(cornerRadius: 5, style: .circular)
                                           .stroke(Color("gray4"), lineWidth: 0.8)
                                   )
                                  }
                              }
                              .padding(.leading, 10)
                              .padding(.trailing, 10)
                          }
       }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PriceCalculatorView()
    }
}
