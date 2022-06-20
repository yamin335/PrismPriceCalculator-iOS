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
                Text("\(moduleGroup.modules.count) modules")
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
    @ObservedObject var viewModel: PriceCalculatorVM
    @Binding var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool
    
    var body: some View {
        if isExpanded {
            VStack(alignment: .leading, spacing: 0) {
                ForEach($moduleGroup.modules, id: \.id) { $module in
                    ModuleListItemView(viewModel: viewModel, module: $module)
                }
            }
        }
    }
}

struct ModuleGroupListItemView: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @State var isExpanded: Bool = false
    @Binding var moduleGroup: ModuleGroup
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ModuleHeaderView(moduleGroup: moduleGroup, isExpanded: $isExpanded)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .onTapGesture {
                    withAnimation {
                        isExpanded = !isExpanded
                    }
                }
            ModuleDetailView(viewModel: viewModel, moduleGroup: $moduleGroup, isExpanded: self.$isExpanded)
        }
    }
}

struct PriceCalculatorView: View {
    let backgroundColors: [Color] = [Color(red: 0.2, green: 0.85, blue: 0.7), Color(red: 0.13, green: 0.55, blue: 0.45)]
    let readMoreColors: [Color] = [Color(red: 0.70, green: 0.22, blue: 0.22), Color(red: 1, green: 0.32, blue: 0.32)]
    let bookmarkColors: [Color] = [Color(red: 0.28, green: 0.28, blue: 0.53), Color(red: 0.44, green: 0.44, blue: 0.83)]
    
    @State var bottomSheetPosition: BottomSheetPosition = .bottom
    
    @State private var showSideMenu = false
    
    @State var baseModuleList: [ServiceModule] = []
    @State var selectedBaseModuleIndex: Int = -1
    
    @State var summaryList: [SummaryItem] = []
    @State var summaryMap: [String : SummaryItem] = [:]
    @State var totalPrice = 0
    let baseTotal = 190000
    
    @ObservedObject var viewModel = PriceCalculatorVM()
    
    var body: some View {
        GeometryReader { geometry in
           NavigationView {
               ScrollView {
                   if selectedBaseModuleIndex >= 0 {
                       ForEach($baseModuleList[selectedBaseModuleIndex].moduleGroups) { $moduleGroup in
                           ModuleGroupListItemView(viewModel: viewModel, moduleGroup: $moduleGroup)
                               .overlay (
                                    RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color("gray4"), lineWidth: 0.8)
                               )
                       }
                   }
               }
               .padding(.leading, 10)
               .padding(.trailing, 10)
               .navigationTitle("Prism Price Calculator")
               .navigationBarItems(trailing: (
                   Button(action: {
                       withAnimation {
                           self.showSideMenu.toggle()
                       }
                   }) {
                       Image(systemName: self.showSideMenu ? "clear" : "line.horizontal.3")
                           .imageScale(.large)
                   }
               )).onReceive(self.viewModel.shouldCalculateData.receive(on: RunLoop.main)) { shouldCalculateData in
                   if shouldCalculateData {
                       summaryList = getSummary(baseModuleList: baseModuleList)
                   }
               }.onReceive(self.viewModel.baseModuleList.receive(on: RunLoop.main)) { baseModuleList in
                   self.baseModuleList = baseModuleList
                   if self.baseModuleList.count > 0 {
                       self.selectedBaseModuleIndex = 0
                   }
               }.onAppear {
                   viewModel.loadAllModuleData()
                   self.totalPrice = baseTotal
                   summaryList = getSummary(baseModuleList: baseModuleList)
               }
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
                     Text("Select Module")
                   
                       .font(.system(size: 14))
                       .padding(.leading, 15.0)
                   }
                 }.padding(.top, 20)
                   Divider().frame(height: 20)
                   ForEach(Array(baseModuleList.enumerated()), id: \.offset) { index, baseModule in
                       Button(action: {
                         withAnimation {
                           self.showSideMenu = false
                             self.selectedBaseModuleIndex = index
                         }
                       }) {
                           if selectedBaseModuleIndex == index {
                               HStack(alignment: .center) {
                                   Text(baseModule.code)
                                       .foregroundColor(.black)
                                       .padding(.horizontal, 20)
                                       .padding(.vertical, 10)
                               }
                               .frame(maxWidth: .infinity)
                               .background(
                                RoundedRectangle(cornerRadius: 0)
                                    .strokeBorder(Color("blue4"), lineWidth: 3)
                                    .foregroundColor(Color("gray5"))
                                    .background(Color("gray6"))
                               )
                           } else {
                               HStack(alignment: .center) {
                                   Text(baseModule.code)
                                       .foregroundColor(Color("blue3"))
                                       .padding(.horizontal, 20)
                                       .padding(.vertical, 10)
                               }
                               .frame(maxWidth: .infinity)
                               .background(
                                RoundedRectangle(cornerRadius: 0)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 3, dash: [10, 5]))
                                    .foregroundColor(Color("gray5"))
                                    .background(Color("grayBlue1"))
                               )
                           }
                       }
                   }
                  Spacer()
                }.padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
           }.bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, options: [ .allowContentDrag, .relativePositionValue], headerContent: {
               //The name of the book as the heading and the author as the subtitle with a divider.
               VStack(alignment: .leading) {
                   Text("Summary")
                       .font(.system(size: 20)).bold()
                       .foregroundColor(Color("textColor1"))
                   
                   HStack(spacing: 5) {
                       Text("Total")
                           .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                       Spacer()
                       Text("৳\(totalPrice)")
                           .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                   }.padding(.top, 1)
               }
               .padding([.top, .bottom, .leading, .trailing], 8)
               .background(RoundedRectangle(cornerRadius: 5).fill(.white)) // Double tap is not working on every point of the header view without a solid background color. Don't know why! may be a bug of SwiftUI.
           }) {
               //A short introduction to the book, with a "Read More" button and a "Bookmark" button.
               SummaryView(summaryList: summaryList).padding([.top, .bottom, .leading, .trailing], 8)
           }
       }
    }
    
    private func getSummary(baseModuleList: [ServiceModule]) -> [SummaryItem] {
        guard selectedBaseModuleIndex >= 0 else {
            return []
        }
        let baseModule = baseModuleList[selectedBaseModuleIndex]
        var isAdded = false
        var price = 0
        for moduleGroup in baseModule.moduleGroups {
            for module in moduleGroup.modules {
                if module.isAdded == true {
                    if let slab1 = module.price?.slab1 {
                        switch slab1 {
                        case .integer(let i):
                            price += i
                        case .string(let j):
                            print(j)
                        }
                    }
                    isAdded = true
                }
                
                for feature in module.features {
                    if feature.isAdded == true {
                        if let slab1 = feature.price?.slab1 {
                            switch slab1 {
                            case .integer(let i):
                                price += i
                            case .string(let j):
                                print(j)
                            }
                        }
                        isAdded = true
                    }
                }
                
                for submodule in module.submodules {
                    for feature in submodule.features {
                        if feature.isAdded == true {
                            if let slab1 = feature.price?.slab1 {
                                switch slab1 {
                                case .integer(let i):
                                    price += i
                                case .string(let j):
                                    print(j)
                                }
                            }
                            isAdded = true
                        }
                    }
                }
            }
        }
        
        if isAdded {
            summaryMap[baseModule.code] = SummaryItem(title: baseModule.name, price: price)
        } else {
            summaryMap.removeValue(forKey: baseModule.code)
        }
        
        var total = 0
        var list: [SummaryItem] = []
        
        for key in summaryMap.keys {
            if let item = summaryMap[key] {
                list.append(item)
                total += item.price
            }
        }
        total += baseTotal
        self.totalPrice = total
        
        return list
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PriceCalculatorView()
    }
}
