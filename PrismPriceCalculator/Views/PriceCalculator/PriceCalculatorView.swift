//
//  PriceCalculatorView.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import SwiftUI

struct ModuleHeaderView: View {
    @Binding var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool
    @State var baseModuleCode: String
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text(moduleGroup.name)
                    .foregroundColor(Color("textColor2"))
                    .font(.headline)
                
                if baseModuleCode != "START" && moduleGroup.modules.count > 0 {
                    Text("\(moduleGroup.modules.count) modules")
                        .foregroundColor(.white)
                        .font(.system(size: 10, weight: .medium))
                        .frame(height: 20)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("blue1")))
                    
                    Text(isExpanded ? "Click to hide Modules" : "Click to show Modules")
                        .foregroundColor(Color("blue1"))
                        .font(.system(size: 10))
                }
                
                Spacer()
            }
            Spacer()
            if baseModuleCode != "START" && moduleGroup.modules.count > 0 {
                VStack(spacing: 6) {
                    HStack(spacing: 8) {
                        Image("ic_select_all")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .scaledToFit()
                            .onTapGesture {
                                withAnimation {
                                    addAll()
                                }
                            }
                        
                        Image("ic_add_circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .scaledToFit()
                            .onTapGesture {
                                withAnimation {
                                    addAll()
                                }
                            }
                        
                        Image("is_toggle_selection")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .scaledToFit()
                            .onTapGesture {
                                withAnimation {
                                    toggleSelection()
                                }
                            }
                        
                        Image("ic_clear_circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .scaledToFit()
                            .onTapGesture {
                                withAnimation {
                                    clearAll()
                                }
                            }
                        
                    }
                    Text((moduleGroup.numberOfSelectedModule ?? 0) > 0 ? "\((moduleGroup.numberOfSelectedModule ?? 0)) of \(moduleGroup.modules.count) selected" : "No module selected")
                        .foregroundColor((moduleGroup.numberOfSelectedModule ?? 0) > 0 ? .white : .black)
                        .font(.system(size: 11, weight: .medium))
                        .frame(height: 24)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .background(RoundedRectangle(cornerRadius: 12, style: .circular).fill((moduleGroup.numberOfSelectedModule ?? 0) > 0 ? Color("green1") : Color("yellow1")))
                    Spacer()
                }
            }
        }.onAppear {
            if ["START", "PIP"].contains(baseModuleCode) {
                isExpanded = true
            }
        }
    }
    
    func addAll() {
        for moduleIndex in 0..<moduleGroup.modules.count {
            if moduleGroup.modules[moduleIndex].isAdded != true {
                moduleGroup.modules[moduleIndex].isAdded = true
                if let numberOfSelectedModule = moduleGroup.numberOfSelectedModule {
                    moduleGroup.numberOfSelectedModule = numberOfSelectedModule + 1
                }
            }
            for featureIndex in 0..<moduleGroup.modules[moduleIndex].features.count {
                if moduleGroup.modules[moduleIndex].features[featureIndex].isAdded != true {
                    moduleGroup.modules[moduleIndex].features[featureIndex].isAdded = true
                }
            }

            for subModuleIndex in 0..<moduleGroup.modules[moduleIndex].submodules.count {
                for featureIndex in 0..<moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features.count {
                    if moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features[featureIndex].isAdded != true {
                        moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features[featureIndex].isAdded = true
                    }
                }
            }
        }
    }
    
    func toggleSelection() {
        for moduleIndex in 0..<moduleGroup.modules.count {
            //var isAdded = false
            
            for featureIndex in 0..<moduleGroup.modules[moduleIndex].features.count {
                moduleGroup.modules[moduleIndex].features[featureIndex].isAdded = !(moduleGroup.modules[moduleIndex].features[featureIndex].isAdded ?? false)
                //isAdded = isAdded || (moduleGroup.modules[moduleIndex].features[featureIndex].isAdded ?? false)
            }

            for subModuleIndex in 0..<moduleGroup.modules[moduleIndex].submodules.count {
                for featureIndex in 0..<moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features.count {
                    moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features[featureIndex].isAdded = !(moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features[featureIndex].isAdded ?? false)
                    //isAdded = isAdded || (moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features[featureIndex].isAdded ?? false)
                }
            }
            
            moduleGroup.modules[moduleIndex].isAdded = !(moduleGroup.modules[moduleIndex].isAdded ?? false)
            
            if moduleGroup.modules[moduleIndex].isAdded == true {
                if let numberOfSelectedModule = moduleGroup.numberOfSelectedModule {
                    moduleGroup.numberOfSelectedModule = numberOfSelectedModule + 1
                }
            } else {
                if let numberOfSelectedModule = moduleGroup.numberOfSelectedModule, numberOfSelectedModule > 0 {
                    moduleGroup.numberOfSelectedModule = numberOfSelectedModule - 1
                }
            }
            
//            if !(moduleGroup.modules[moduleIndex].isAdded ?? false) {
//                moduleGroup.modules[moduleIndex].isAdded = (moduleGroup.modules[moduleIndex].isAdded ?? false) || isAdded
//                if let numberOfSelectedModule = moduleGroup.numberOfSelectedModule, moduleGroup.modules[moduleIndex].isAdded == true {
//                    moduleGroup.numberOfSelectedModule = numberOfSelectedModule + 1
//                }
//            }
        }
    }

    func clearAll() {
        for moduleIndex in 0..<moduleGroup.modules.count {
            if moduleGroup.modules[moduleIndex].isAdded == true {
                moduleGroup.modules[moduleIndex].isAdded = false
                if let numberOfSelectedModule = moduleGroup.numberOfSelectedModule, numberOfSelectedModule > 0 {
                    moduleGroup.numberOfSelectedModule = numberOfSelectedModule - 1
                }
            }
            for featureIndex in 0..<moduleGroup.modules[moduleIndex].features.count {
                if moduleGroup.modules[moduleIndex].features[featureIndex].isAdded == true {
                    moduleGroup.modules[moduleIndex].features[featureIndex].isAdded = false
                }
            }

            for subModuleIndex in 0..<moduleGroup.modules[moduleIndex].submodules.count {
                for featureIndex in 0..<moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features.count {
                    if moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features[featureIndex].isAdded == true {
                        moduleGroup.modules[moduleIndex].submodules[subModuleIndex].features[featureIndex].isAdded = false
                    }
                }
            }
        }
    }
}

struct ModuleDetailView: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @Binding var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool
    @State var baseModuleCode: String
    
    var body: some View {
        if isExpanded {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array($moduleGroup.modules.enumerated()), id: \.offset) { index, $module in
                    ModuleListItemView(viewModel: viewModel, moduleGroup: $moduleGroup, module: $module, baseModuleCode: baseModuleCode, index: index)
                }
                
                let validMultiplierList: [MultiplierClass] = getValidMultiplierList(moduleGroup: moduleGroup)
                
                if !validMultiplierList.isEmpty {
                    ForEach(Array(validMultiplierList.enumerated()), id: \.offset) { index, multiplier in
                        MultiplierListItem(viewModel: viewModel, label: multiplier.label)
                    }
                }
            }
        }
    }
    
    private func getValidMultiplierList(moduleGroup: ModuleGroup) -> [MultiplierClass] {
        var validMultiplierList: [MultiplierClass] = []
        let shownMultipliers = moduleGroup.showMultiplier ?? ""
        let validMultiplierClasses = shownMultipliers.components(separatedBy: ",") 
        
        if !validMultiplierClasses.isEmpty {
            for multiplier in moduleGroup.multipliers {
                if validMultiplierClasses.contains(multiplier.code) {
                    validMultiplierList.append(multiplier)
                }
            }
            return validMultiplierList
        } else {
            return []
        }
    }
}

struct ModuleGroupListItemView: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @State var isExpanded: Bool = false
    @Binding var moduleGroup: ModuleGroup
    @State var baseModuleCode: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ModuleHeaderView(moduleGroup: $moduleGroup, isExpanded: $isExpanded, baseModuleCode: baseModuleCode)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(.white)
                .onTapGesture {
                    withAnimation {
                        isExpanded = !isExpanded
                    }
                }
            ModuleDetailView(viewModel: viewModel, moduleGroup: $moduleGroup, isExpanded: self.$isExpanded, baseModuleCode: baseModuleCode)
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
    
    @State var costSoftwareLicense = 0
    @State var costAdditionalUsers = 150000
    @State var costImplementation = 0
    @State var costRequirementAnalysis = 0
    @State var costDeployment = 10000
    @State var costConfiguration = 0
    @State var costOnsiteAdoptionSupport = 0
    @State var costTraining = 0
    @State var costProjectManagement = 0
    @State var costSoftwareCustomizationTotal = 0
    @State var costSoftwareCustomization = 0
    @State var costCustomizedReport = 0
    @State var costConsultancyServices = 0
    @State var costConsultancy = 0
    @State var costAnnualMaintenanceTotal = 0
    @State var costAnnualMaintenance = 30000
    @State var costTotal = 0
    
    @ObservedObject var viewModel = PriceCalculatorVM()
    
    var body: some View {
        GeometryReader { geometry in
           VStack {
               ScrollView {
                   VStack(alignment: .leading, spacing: 20) {
                       if selectedBaseModuleIndex >= 0 {
                           if ["START", "FMS", "HCM", "PPC", "EAM", "CSC", "PIP"].contains(baseModuleList[selectedBaseModuleIndex].code) {
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
                                   if baseModuleList[selectedBaseModuleIndex].code == "START" {
                                       HeaderStart(viewModel: viewModel)
                                   } else if baseModuleList[selectedBaseModuleIndex].code == "FMS" {
                                       HeaderFMS(viewModel: viewModel)
                                   } else if baseModuleList[selectedBaseModuleIndex].code == "HCM" {
                                       HeaderHCM(viewModel: viewModel)
                                   } else if baseModuleList[selectedBaseModuleIndex].code == "PPC" {
                                       HeaderPPC(viewModel: viewModel)
                                   } else if baseModuleList[selectedBaseModuleIndex].code == "EAM" {
                                       HeaderEAM(viewModel: viewModel)
                                   } else if baseModuleList[selectedBaseModuleIndex].code == "CSC" {
                                       HeaderCSC(viewModel: viewModel)
                                   } else if baseModuleList[selectedBaseModuleIndex].code == "PIP" {
                                       HeaderPIP(viewModel: viewModel)
                                   }
                               }
                               .background(RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color("blue1"), lineWidth: 1))
                           }
                           
                           ForEach($baseModuleList[selectedBaseModuleIndex].moduleGroups) { $moduleGroup in
                               ModuleGroupListItemView(viewModel: viewModel, moduleGroup: $moduleGroup, baseModuleCode: baseModuleList[selectedBaseModuleIndex].code)
                                   .overlay (
                                        RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color("gray4"), lineWidth: 0.8)
                                   )
                           }
                       }
                   }
                   .padding(.bottom, 100)
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
               }.onReceive(self.viewModel.baseModuleListPublisher.receive(on: RunLoop.main)) { baseModuleList in
                   self.baseModuleList = baseModuleList
                   if self.baseModuleList.count > 0 {
                       self.selectedBaseModuleIndex = 0
                   }
               }.onAppear {
                   viewModel.loadAllModuleData()
                   costAdditionalUsers = 150000
                   costDeployment = 10000
                   costAnnualMaintenance = 30000

                   calculateSummaryCost(moduleCost: 0)
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
                       Text("৳\(costTotal)")
                           .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                   }.padding(.top, 1)
               }
               .padding([.top, .bottom, .leading, .trailing], 8)
               .background(RoundedRectangle(cornerRadius: 5).fill(.white)) // Double tap is not working on every point of the header view without a solid background color. Don't know why! may be a bug of SwiftUI.
           }) {
               //A short introduction to the book, with a "Read More" button and a "Bookmark" button.
               SummaryView(summaryList: summaryList, costSoftwareLicense: $costSoftwareLicense, costAdditionalUsers: $costAdditionalUsers, costImplementation: $costImplementation, costRequirementAnalysis: $costRequirementAnalysis, costDeployment: $costDeployment, costConfiguration: $costConfiguration, costOnsiteAdoptionSupport: $costOnsiteAdoptionSupport, costTraining: $costTraining, costProjectManagement: $costProjectManagement, costSoftwareCustomizationTotal: $costSoftwareCustomizationTotal, costSoftwareCustomization: $costSoftwareCustomization, costCustomizedReport: $costCustomizedReport, costConsultancyServices: $costConsultancyServices, costConsultancy: $costConsultancy, costAnnualMaintenanceTotal: $costAnnualMaintenanceTotal, costAnnualMaintenance: $costAnnualMaintenance)
                   .padding([.top, .bottom, .leading, .trailing], 8)
                   .background(.white)
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
        
        var moduleCost = 0
        var list: [SummaryItem] = []
        
        for key in summaryMap.keys {
            if let item = summaryMap[key] {
                list.append(item)
                moduleCost += item.price
            }
        }
        
        calculateSummaryCost(moduleCost: moduleCost)
        
        return list
    }
    
    private func calculateSummaryCost(moduleCost: Int) {
        costSoftwareLicense = moduleCost + costAdditionalUsers

        costImplementation = costRequirementAnalysis + costDeployment + costConfiguration + costOnsiteAdoptionSupport + costTraining + costProjectManagement

        costSoftwareCustomizationTotal = costSoftwareCustomization + costCustomizedReport

        costConsultancyServices = costConsultancy

        costAnnualMaintenanceTotal = costAnnualMaintenance

        costTotal = costSoftwareLicense + costImplementation + costSoftwareCustomizationTotal + costConsultancyServices + costAnnualMaintenanceTotal
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PriceCalculatorView()
    }
}
