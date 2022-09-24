//
//  PriceCalculatorView.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import SwiftUI

struct ModuleGroupHeaderView: View {
    @Binding var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool
    @State var baseModuleCode: String
    @ObservedObject var viewModel: PriceCalculatorVM
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text(moduleGroup.name ?? "")
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
        }
        self.viewModel.shouldCalculateData.send(true)
    }
    
    func toggleSelection() {
        for moduleIndex in 0..<moduleGroup.modules.count {
            for featureIndex in 0..<moduleGroup.modules[moduleIndex].features.count {
                moduleGroup.modules[moduleIndex].features[featureIndex].isAdded = !(moduleGroup.modules[moduleIndex].features[featureIndex].isAdded ?? false)
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
        }
        self.viewModel.shouldCalculateData.send(true)
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
        }
        self.viewModel.shouldCalculateData.send(true)
    }
}

struct ModuleGroupDetailView: View {
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
            }
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
            ModuleGroupHeaderView(moduleGroup: $moduleGroup, isExpanded: $isExpanded, baseModuleCode: baseModuleCode, viewModel: viewModel)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(.white)
                .onTapGesture {
                    withAnimation {
                        isExpanded = !isExpanded
                    }
                }
            ModuleGroupDetailView(viewModel: viewModel, moduleGroup: $moduleGroup, isExpanded: self.$isExpanded, baseModuleCode: baseModuleCode)
        }
    }
}

struct PriceCalculatorView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appGlobalState: AppState
    var productId: String
    var quotationId: String
    let backgroundColors: [Color] = [Color(red: 0.2, green: 0.85, blue: 0.7), Color(red: 0.13, green: 0.55, blue: 0.45)]
    let readMoreColors: [Color] = [Color(red: 0.70, green: 0.22, blue: 0.22), Color(red: 1, green: 0.32, blue: 0.32)]
    let bookmarkColors: [Color] = [Color(red: 0.28, green: 0.28, blue: 0.53), Color(red: 0.44, green: 0.44, blue: 0.83)]
    
    @State private var showSideMenu = false
    
    @State var baseModuleList: [BaseServiceModule] = []
    @State var selectedBaseModuleIndex: Int = -1
    
    @State var submitButtonDisabled = true
    
    
    @StateObject var viewModel = PriceCalculatorVM()
    
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
    @State private var showLoader = false
    
    @State private var hasHeaderView = false
    
    @State private var bottomSheetShown = false
    
    var bottomSheetHeaderView: some View {
        VStack(alignment: .leading) {
            Text("Summary")
                .font(.system(size: 20)).bold()
                .foregroundColor(Color("textColor1"))
            
            HStack(spacing: 5) {
                Text("Total")
                    .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                Spacer()
                Text("৳\(viewModel.costTotal)")
                    .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
            }.padding(.top, 1)
        }
        .padding([.leading, .trailing])
        .background(RoundedRectangle(cornerRadius: 5).fill(.white))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        if selectedBaseModuleIndex >= 0 {
                            if hasHeaderView {
                                VStack {
                                    HStack(alignment: .center, spacing: 8) {
                                        Text("Licensing Parameters")
                                            .foregroundColor(Color("textColor1"))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.top, 10)
                                    
                                    Divider().padding(.horizontal, 10)
                                    
                                    ForEach($baseModuleList[selectedBaseModuleIndex].multipliers, id: \.id) { $multiplier in
                                        let hideInApp = multiplier.slabConfig?.hideInApp ?? false
                                        let label = (multiplier.label ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                                        if !hideInApp && !label.isEmpty {
                                            MultiplierListItem(viewModel: viewModel, multiplier: $multiplier)
                                        }
                                    }
                                }
                                .background(RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color("blue1"), lineWidth: 1))
                            }
                            
                            ForEach($baseModuleList[selectedBaseModuleIndex].moduleGroups) { $moduleGroup in
                                ModuleGroupListItemView(viewModel: viewModel, moduleGroup: $moduleGroup, baseModuleCode: baseModuleList[selectedBaseModuleIndex].code ?? "")
                                    .overlay (
                                         RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color("gray4"), lineWidth: 0.8)
                                    )
                            }
                            .onReceive(self.viewModel.selectedMultiplierPublisher.receive(on: RunLoop.main)) { triple in
                                calculateModuleAndFeaturePrice(with: triple)
                            }
                        }
                    }
                    .padding(.bottom, 100)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .navigationBarTitleDisplayMode(.inline)
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
                        viewModel.summaryList = getSummary(baseModuleList: baseModuleList)
                    }
                }.onReceive(self.viewModel.baseModuleListPublisher.receive(on: RunLoop.main)) { baseModuleList in
                    self.baseModuleList = baseModuleList
                    if self.baseModuleList.count > 0 {
                        self.selectedBaseModuleIndex = 0
                        prepareHeaderView()
                        viewModel.summaryList = getSummary(baseModuleList: self.baseModuleList)
                    }
                }.onReceive(self.viewModel.baseModuleListAndQuotationDetailsPublisher.receive(on: RunLoop.main)) { (baseModuleList, quotation)  in
                    self.baseModuleList = baseModuleList
                    self.selectedBaseModuleIndex = 0
                    prepareHeaderView()
                    viewModel.summaryList = getSummary(baseModuleList: self.baseModuleList)
                }.onAppear {
                    if !quotationId.isEmpty {
                        viewModel.quotationDetailsWithProductDetails(productId: productId, quotationId: quotationId)
                    } else {
                        viewModel.productDetails(productId: productId)
                    }
                    viewModel.calculateSummaryCost(moduleCost: 0)
                    viewModel.summaryList = getSummary(baseModuleList: baseModuleList)
                }
                
                DraggableBottomSheet(
                    isOpen: self.$bottomSheetShown,
                    maxHeight: geometry.size.height + 25,
                    headerView: {
                        bottomSheetHeaderView
                    }) {
                    VStack(spacing: 0) {
                        SummaryView(submitButtonDisabled: $submitButtonDisabled, viewModel: viewModel).background(.white)
                    }
                }
                
                if self.showSuccessToast {
                    SuccessToast(message: self.successMessage).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation() {
                                self.showSuccessToast = false
                                self.successMessage = ""
                            }
                        }
                    }
                }

                if showErrorToast {
                    ErrorToast(message: self.errorMessage).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation() {
                                self.showErrorToast = false
                                self.errorMessage = ""
                            }
                        }
                    }
                }

                if self.showLoader {
                    HStack(alignment: .center) {
                        Spacer()
                        SpinLoaderView()
                        Spacer()
                    }
                }
            }.onReceive(self.viewModel.quotationStatusPublisher.receive(on: RunLoop.main)) { isSubmitted in
               if isSubmitted {
                   withAnimation {
                       AppGlobalValues.isQuotationSubmitted = true
                       bottomSheetShown = false
                       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                           self.presentationMode.wrappedValue.dismiss()
                       }
                   }
               }
           }.onReceive(self.viewModel.showLoader.receive(on: RunLoop.main)) { isShowing in
               self.showLoader = isShowing
           }.onReceive(self.viewModel.successToastPublisher.receive(on: RunLoop.main)) {
               showToast, message in
               self.successMessage = message
               withAnimation() {
                   self.showSuccessToast = showToast
               }
           }.onReceive(self.viewModel.errorToastPublisher.receive(on: RunLoop.main)) {
               showToast, message in
               self.errorMessage = message
               withAnimation() {
                   self.showErrorToast = showToast
               }
           }.onReceive(self.viewModel.submitEnableDisablePublisher.receive(on: RunLoop.main)) { isValid in
               self.submitButtonDisabled = !isValid
           }
       }
        .edgesIgnoringSafeArea(.bottom)
        .sideMenu(isShowing: $showSideMenu) {
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
                          self.prepareHeaderView()
                      }
                    }) {
                        if selectedBaseModuleIndex == index {
                            HStack(alignment: .center) {
                                Text(baseModule.code ?? "")
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
                                Text(baseModule.code ?? "")
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
        }
    }
    
    private func calculateModuleAndFeaturePrice(with triple: (String, Int, String)) {
        guard let baseModuleCode = baseModuleList[selectedBaseModuleIndex].code, let multiplierMap = viewModel.responsibleMultipliersOfBaseModules[baseModuleCode], multiplierMap[triple.0] == true else {
            return
        }
        for moduleGroupIndex in 0..<$baseModuleList[selectedBaseModuleIndex].moduleGroups.count {
            for moduleIndex in 0..<$baseModuleList[selectedBaseModuleIndex].moduleGroups[moduleGroupIndex].modules.count {
                guard let moduleMultiplierCode = baseModuleList[selectedBaseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex].multiplier else {
                    return
                }
                
                if triple.0 == moduleMultiplierCode {
                    viewModel.calculateModulePrice(module: &baseModuleList[selectedBaseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex], with: triple.1, customValue: triple.2)
                }
                
                for featureIndex in 0..<$baseModuleList[selectedBaseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex].features.count {
                    
                    guard let featureMultiplierCode = baseModuleList[selectedBaseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex].features[featureIndex].multiplier else {
                        return
                    }
                    
                    if triple.0 == featureMultiplierCode {
                        viewModel.calculateFeaturePrice(feature: &baseModuleList[selectedBaseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex].features[featureIndex], with: triple.1, customValue: triple.2)
                    }
                }
            }
        }
    }
    
    private func prepareHeaderView() {
        if baseModuleList.isEmpty {
            return
        }

        let baseModule = baseModuleList[selectedBaseModuleIndex]
        if baseModule.moduleGroups.isEmpty {
            return
        }
        
        var multipliersMap: [String : MultiplierClass] = [:]
        var multipliers: [MultiplierClass] = []

        for multiplier in baseModule.multipliers {
            let hideInApp = multiplier.slabConfig?.hideInApp ?? false
            let label = multiplier.label?.trimmingCharacters(in: .whitespacesAndNewlines)
            if !hideInApp && multipliersMap[multiplier.code ?? ""] == nil && !(label ?? "").isEmpty {
                multipliersMap[multiplier.code ?? ""] = multiplier
            }
        }

        for key in multipliersMap.keys {
            if let multiplier = multipliersMap[key] {
                multipliers.append(multiplier)
            }
        }

        self.hasHeaderView = !multipliers.isEmpty
    }
    
    private func getSummary(baseModuleList: [BaseServiceModule]) -> [SummaryItem] {
        guard selectedBaseModuleIndex >= 0 else {
            return []
        }
        let baseModule = baseModuleList[selectedBaseModuleIndex]
        var isAdded = false
        var price = 0
        
        var summaryModuleFeatureList: [SummaryResponseFeature] = []
        var summaryModuleTotalPrice = 0
        
        for moduleGroup in baseModule.moduleGroups {
            for module in moduleGroup.modules {
                if module.isAdded == true {
                    var slabPrice = 0
                    if module.defaultprice == 0 {
                        if !module.price.isEmpty {
                            let modulePrice = module.price[0]
                            if !modulePrice.isEmpty {
                                let tempDPrice = Double(modulePrice) ?? 0.0
                                slabPrice = Int(tempDPrice)
                            }
                        }
                    } else {
                        slabPrice = Int(module.defaultprice ?? 0.0)
                    }
                    
                    price += slabPrice
                    
                    summaryModuleTotalPrice += slabPrice
                    summaryModuleFeatureList.append(SummaryResponseFeature(name: module.name, code: module.code, parentcode: "", description: module.description, multipliercode: "", type: "module", excludeInAll: module.excludeInAll, discount: 0, totalamount: Int(module.defaultprice ?? 0.0), multiplier: module.multiplier, price: module.price, defaultprice: module.defaultprice ?? 0.0))
                    
                    isAdded = true
                }
                
                for feature in module.features {
                    if feature.isAdded == true {
                        var slabPrice = 0
                        if feature.defaultprice == 0 {
                            if !feature.price.isEmpty {
                                let featurePrice = feature.price[0]
                                if !featurePrice.isEmpty {
                                    let tempDPrice = Double(featurePrice) ?? 0.0
                                    slabPrice = Int(tempDPrice)
                                }
                            }
                        } else {
                            slabPrice = Int(feature.defaultprice ?? 0.0)
                        }
                        
                        price += slabPrice
                        
                        summaryModuleTotalPrice += slabPrice
                        summaryModuleFeatureList.append(SummaryResponseFeature(name: feature.name, code: feature.code, parentcode: "", description: feature.description, multipliercode: "", type: "feature", excludeInAll: feature.excludeInAll, discount: 0, totalamount: Int(feature.defaultprice ?? 0.0), multiplier: feature.multiplier, price: feature.price, defaultprice: feature.defaultprice ?? 0.0))
                        
                        isAdded = true
                    }
                }
            }
        }
        
        var licensingParameters: [LicensingParameter] = []
        
        // Add all valid parameters
        
        for multiplier in baseModuleList[selectedBaseModuleIndex].multipliers {
            let hideInApp = multiplier.slabConfig?.hideInApp ?? false
            let label = (multiplier.label ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            if !hideInApp && !label.isEmpty {
                
                if let customValue = multiplier.customValue, !customValue.isEmpty {
                    licensingParameters.append(LicensingParameter(name: multiplier.code, value: customValue, slabid: 0))
                    continue
                }
                
                if multiplier.slabConfig?.inputType == "slider" {
                    continue
                }
                
                var chips: [ChipsDataModel] = []
                for (index, item) in multiplier.slabs.enumerated() {
                    let regex = NSRegularExpression(#"^[0-9]+(?:[.,][0-9]+)*$"#)
                    let isNumber = regex.matches(in: item)
                    
                    if isNumber {
                        if multiplier.slabConfig?.showRange == true {
                            let slabText = multiplier.slabTexts.count > index ? multiplier.slabTexts[index] : ""
                            let increment = 1
                            
                            let itemValue = Int(Double(item) ?? 0.0)
                            
                            var startItem = increment
                            if index > 0 {
                                startItem = Int(Double(multiplier.slabs[index-1]) ?? 0.0) + increment
                            }
                            
                            let chipItem: ChipsDataModel = ChipsDataModel(label: slabText.isEmpty ? "\(startItem)-\(itemValue)" : "\(slabText)(\(startItem)-\(itemValue))")
                            chips.append(chipItem)
                        } else {
                            let slabText = multiplier.slabTexts.count > index ? multiplier.slabTexts[index] : ""
                            
                            let itemValue = Int(Double(item) ?? 0.0)
                            
                            let chipItem: ChipsDataModel = ChipsDataModel(label: slabText.isEmpty ? "\(itemValue)" : "\(slabText)(\(itemValue))")
                            chips.append(chipItem)
                        }
                    } else {
                        let chipItem: ChipsDataModel = ChipsDataModel(label: item)
                        chips.append(chipItem)
                    }
                }
                
                if chips.count > (multiplier.slabIndex ?? 0) {
                    licensingParameters.append(LicensingParameter(name: multiplier.code, value: chips[multiplier.slabIndex ?? 0].label, slabid: 0))
                }
            }
        }
        
        if selectedBaseModuleIndex == 0 {
            self.viewModel.softwareLicenseModuleMap[baseModule.code ?? ""] = SummaryResponseSoftwareLicenseModule(licensingparameters: licensingParameters, name: baseModule.name, code: baseModule.code, description: "", selfcode: "", defaultprice: 0, totalamount: summaryModuleTotalPrice, discount: 0, features: summaryModuleFeatureList, multiplier: "", price: nil, excludeInAll: false)
        } else {
            if isAdded {
                viewModel.summaryMap[baseModule.code ?? ""] = SummaryItem(title: baseModule.name ?? "", price: price)
                
                self.viewModel.softwareLicenseModuleMap[baseModule.code ?? ""] = SummaryResponseSoftwareLicenseModule(licensingparameters: licensingParameters, name: baseModule.name, code: baseModule.code, description: "", selfcode: "", defaultprice: 0, totalamount: summaryModuleTotalPrice, discount: 0, features: summaryModuleFeatureList, multiplier: "", price: nil, excludeInAll: false)
                viewModel.moduleChangeMapNew[baseModule.code ?? ""] = price
            } else {
                viewModel.summaryMap.removeValue(forKey: baseModule.code ?? "")
                self.viewModel.softwareLicenseModuleMap.removeValue(forKey: baseModule.code ?? "")
                viewModel.moduleChangeMapNew.removeValue(forKey: baseModule.code ?? "")
            }
        }
        
        self.viewModel.submitEnableDisablePublisher.send(self.viewModel.softwareLicenseModuleMap.count > 0)
        
        var moduleCost = 0
        var list: [SummaryItem] = []
        
        for key in viewModel.summaryMap.keys {
            if let item = viewModel.summaryMap[key] {
                list.append(item)
                moduleCost += item.price
            }
        }
        
        viewModel.calculateSummaryCost(moduleCost: moduleCost)
        
        return list
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PriceCalculatorView(productId: "prismperp", quotationId: "").environmentObject(AppState())
        }
    }
}
