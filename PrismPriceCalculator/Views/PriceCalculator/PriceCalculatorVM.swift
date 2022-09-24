//
//  PriceCalculatorVM.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation
import Combine
import UIKit

class PriceCalculatorVM: BaseViewModel {
    @Published var costSoftwareLicense = 0
    @Published var costAdditionalUsers = 0
    @Published var additionalUsers = 5
    @Published var usersIncluded = AppConstants.additionalUsers
    @Published var costImplementation = 0
    @Published var costRequirementAnalysis = 0
    @Published var costDeployment = 0
    @Published var costConfiguration = 0
    @Published var costOnsiteAdoptionSupport = 0
    @Published var costTraining = 0
    @Published var costProjectManagement = 0
    @Published var costSoftwareCustomizationTotal = 0
    @Published var costSoftwareCustomization = 0
    @Published var costCustomizedReport = 0
    @Published var costConsultancyServices = 0
    @Published var costConsultancy = 0
    @Published var costAnnualMaintenanceTotal = 0
    @Published var costAnnualMaintenance = 30000
    @Published var costTotal = 0
    
    @Published var summaryList: [SummaryItem] = []
    @Published var summaryMap: [String : SummaryItem] = [:]
    
    var baseModuleListPublisher = PassthroughSubject<[BaseServiceModule], Never>()
    var shouldCalculateData = PassthroughSubject<Bool, Never>()
    var calculateSelectedModuleFor = PassthroughSubject<String, Never>()
    
    private var submitQuotationSubscriber: AnyCancellable? = nil
    private var updateQuotationSubscriber: AnyCancellable? = nil
    private var productDetailsSubscriber: AnyCancellable? = nil
    private var quotationDetailsAndProductDetailsSubscriber: AnyCancellable? = nil
    var quotationStatusPublisher = PassthroughSubject<Bool, Never>()
    
    var submitEnableDisablePublisher = PassthroughSubject<Bool, Never>()
    var selectedMultiplierPublisher = PassthroughSubject<(String, Int, String), Never>()
    var baseModuleListAndQuotationDetailsPublisher = PassthroughSubject<([BaseServiceModule], SummaryResponseQuotation), Never>()
    
    var softwareLicenseModuleList: [SummaryResponseSoftwareLicenseModule] = []
    var softwareLicenseModuleMap: [String : SummaryResponseSoftwareLicenseModule] = [:]
    
    var responsibleMultipliersOfBaseModules: [String : [String : Bool]] = [:]
    
    var baseModuleList: [BaseServiceModule] = []
    
    var moduleChangeMapOld: [String : Int?] = [:]
    var moduleChangeMapNew: [String : Int?] = [:]
    
    var quotationDetails: SummaryResponseQuotation? = nil
    
    deinit {
        updateQuotationSubscriber?.cancel()
        quotationDetailsAndProductDetailsSubscriber?.cancel()
        submitQuotationSubscriber?.cancel()
        productDetailsSubscriber?.cancel()
    }
    
//    func loadAllModuleData() {
//        guard let url = Bundle.main.url(forResource: "divine", withExtension: "json") else {
//            print("Json file not found")
//            return
//        }
//
//        guard let data = try? Data(contentsOf: url),
//        let list = try? JSONDecoder().decode([ServiceModule].self, from: data) else {
//            print("Json file parsing failed!")
//            return
//        }
//
//        var baseModuleList = list
//
//        for baseModuleIndex in 0..<baseModuleList.count {
//            for moduleGroupIndex in 0..<baseModuleList[baseModuleIndex].moduleGroups.count {
//                baseModuleList[baseModuleIndex].moduleGroups[moduleGroupIndex].numberOfSelectedModule = 0
//            }
//        }
//        baseModuleListPublisher.send(baseModuleList)
//    }
    
    func productDetails(productId: String) {
        self.submitQuotationSubscriber = ApiService.productDetails(productId: productId, viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                        let des = error.localizedDescription
                        print(des)
                }
            }, receiveValue: { response in
                if response.code == 2000001 {
                    guard let baseModuleList = response.data?.Modules else {
                        self.errorToastPublisher.send((true, response.msg ?? "Failed! please try again later"))
                        return
                    }
                    self.baseModuleList = baseModuleList
                    self.prepareResponsibleMultipliersList()
                    self.baseModuleListPublisher.send(self.baseModuleList)
                } else {
                    self.errorToastPublisher.send((true, response.msg ?? "Failed! please try again later"))
                }
            })
    }
    
    func submitQuotation(quotationStoreBody: SummaryStoreModel) {
        self.submitQuotationSubscriber = ApiService.submitQuotation(quotationStoreBody: quotationStoreBody, viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { response in
                if response.code == 2000001 {
                    self.successToastPublisher.send((true, response.msg ?? "Quotation successfully submitted!"))
                    self.quotationStatusPublisher.send(true)
                } else {
                    self.errorToastPublisher.send((true, response.msg ?? "Submission failed! please try again later"))
                }
            })
    }
    
    func updateQuotation(quotationUpdateBody: SummaryResponseQuotation) {
        self.updateQuotationSubscriber = ApiService.updateQuotation(quotationUpdateBody: quotationUpdateBody, viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { response in
                if response.code == 2000001 {
                    self.successToastPublisher.send((true, response.msg ?? "Quotation successfully updated!"))
                    self.quotationStatusPublisher.send(true)
                } else {
                    self.errorToastPublisher.send((true, response.msg ?? "Submission failed! please try again later"))
                }
            })
    }
    
    func quotationDetailsWithProductDetails(productId: String, quotationId: String) {
        guard let productDetailsPublisher = ApiService.productDetails(productId: productId, viewModel: self),
        let quotationDetailsPublisher = ApiService.quotationDetails(quotationId: quotationId, viewModel: self) else {
            return
        }
        self.quotationDetailsAndProductDetailsSubscriber = Publishers.Zip(productDetailsPublisher, quotationDetailsPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { productDetailsresponse, quotationDetailsResponse in
                
                if productDetailsresponse.code != 2000001 {
                    self.errorToastPublisher.send((true, productDetailsresponse.msg ?? "Failed to load product data! please try again later"))
                } else if quotationDetailsResponse.code != 2000001 {
                    self.errorToastPublisher.send((true, quotationDetailsResponse.msg ?? "Failed to load quotation data! please try again later"))
                } else {
                    guard let baseModuleList = productDetailsresponse.data?.Modules, !baseModuleList.isEmpty else {
                        self.errorToastPublisher.send((true, productDetailsresponse.msg ?? "Failed to load product data! please try again later"))
                        return
                    }
                    
                    guard let quotation = quotationDetailsResponse.data?.QuotationSummary else {
                        self.errorToastPublisher.send((true, productDetailsresponse.msg ?? "Failed to load product data! please try again later"))
                        return
                    }
                    
                    self.quotationDetails = quotation
                    
                    self.baseModuleList = baseModuleList
                    self.prepareResponsibleMultipliersList()
                    self.syncQuotationDataWithProductList(quotation: quotation)
                    self.baseModuleListAndQuotationDetailsPublisher.send((self.baseModuleList, quotation))
                }
            })
    }
    
    private func syncQuotationDataWithProductList(quotation: SummaryResponseQuotation) {
        var quotationModuleMap: [String : SummaryResponseFeature] = [:]
        var multiplierMap: [String : (String, Int?)] = [:]
        
        if let customizationModules = quotation.Customization?.modules {
            for item in customizationModules {
                switch item.name {
                case "Software Customization":
                    costSoftwareCustomization = (item.details_value ?? 0) * (item.details_multiplier ?? 0)
                case "Customized Report":
                    costCustomizedReport = (item.details_value ?? 0) * (item.details_multiplier ?? 0)
                default:
                    print("Slider value did not matched!")
                }
            }
        }
        
        let softwareLicenseModules = quotation.Software_License?.modules ?? []
        
        for module in softwareLicenseModules {
            guard let moduleCode = module.code, let moduleName = module.name,
                    let moduleTotalAmount = module.totalamount else {
                continue
            }
            moduleChangeMapOld[moduleCode] = module.totalamount
            moduleChangeMapNew[moduleCode] = module.totalamount
            
            let parameters = module.licensingparameters ?? []
            for param in parameters {
                if let value = param.value {
                    multiplierMap["\(param.name ?? "")\(module.code ?? "")"] = (value, nil)
                }
            }
            
            for feature in module.features {
                guard let featureCode = feature.code else {
                    continue
                }
                quotationModuleMap[featureCode] = feature
            }
            if moduleCode != "START" {
                summaryMap[moduleCode] = SummaryItem(title: moduleName, price: moduleTotalAmount)
            }
            
            softwareLicenseModuleMap[moduleCode] = module
        }
        
        guard !quotationModuleMap.isEmpty else {
            return
        }
        
        for baseIndex in baseModuleList.indices {
            for multiplierIndex in baseModuleList[baseIndex].multipliers.indices {
                let multiplier = baseModuleList[baseIndex].multipliers[multiplierIndex]
                
                if multiplier.slabLabels.isEmpty {
                    continue
                }
                
                var isCustomValue = false
                let keyCode = "\(multiplier.code ?? "")\(baseModuleList[baseIndex].code ?? "")"
                guard let pair = multiplierMap[keyCode] else {
                    continue
                }
                
                for slabIndex in multiplier.slabLabels.indices {
                    let slabLabel = baseModuleList[baseIndex].multipliers[multiplierIndex].slabLabels[slabIndex]
                    if (pair.0 == slabLabel) {
                        baseModuleList[baseIndex].multipliers[multiplierIndex].slabIndex = slabIndex
                        multiplierMap[keyCode] = (pair.0, slabIndex)
                        isCustomValue = false
                        break
                    } else {
                        // Custom value
                        isCustomValue = true
                    }
                }
                if (isCustomValue) {
                    baseModuleList[baseIndex].multipliers[multiplierIndex].customValue = pair.0
                    baseModuleList[baseIndex].multipliers[multiplierIndex].slabIndex = -1 //baseModuleList[baseIndex].multipliers[multiplierIndex].slabLabels.count()
                }
            }
            
            for groupIndex in baseModuleList[baseIndex].moduleGroups.indices {
                for moduleIndex in baseModuleList[baseIndex].moduleGroups[groupIndex].modules.indices {
                    if let moduleMultiplierCode = baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].multiplier {
                        let keyModule = "\(moduleMultiplierCode)\(baseModuleList[baseIndex].code ?? "")"
                        
                        if let pair = multiplierMap[keyModule], let slabIndex = pair.1 {
                            calculateModulePrice(module: &baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex], with: slabIndex, customValue: "")
                        }
                        
                        if let moduleCode = baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].code, quotationModuleMap[moduleCode] != nil {
                            baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].isAdded = true
                            if let numberOfSelectedModule = baseModuleList[baseIndex].moduleGroups[groupIndex].numberOfSelectedModule {
                                baseModuleList[baseIndex].moduleGroups[groupIndex].numberOfSelectedModule = numberOfSelectedModule + 1
                            }
                        }
                    }
                    
                    for featureIndex in baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].features.indices {
                        if let featureMultiplierCode = baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].features[featureIndex].multiplier {
                            let keyFeature = "\(featureMultiplierCode)\(baseModuleList[baseIndex].code ?? "")"
                            if let pair = multiplierMap[keyFeature], let slabIndex = pair.1 {
                                calculateFeaturePrice(feature: &baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].features[featureIndex], with: slabIndex, customValue: "")
                            }
                            
                            if let featureCode = baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].features[featureIndex].code, quotationModuleMap[featureCode] != nil {
                                baseModuleList[baseIndex].moduleGroups[groupIndex].modules[moduleIndex].features[featureIndex].isAdded = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func prepareResponsibleMultipliersList() {
        if !baseModuleList.isEmpty {
            var baseMultiplierMap: [String : [String : Bool]] = [:]
            for baseModuleIndex in baseModuleList.indices {
                //Configure multiplier labels for every multiplier of a base module
                prepareMultiplierLabels(baseModuleIndex: baseModuleIndex)
                
                var multiplierMap: [String : Bool] = [:]
                for moduleGroupIndex in baseModuleList[baseModuleIndex].moduleGroups.indices {
                    for moduleIndex in baseModuleList[baseModuleIndex].moduleGroups[moduleGroupIndex].modules.indices {
                        if let moduleMultiplier = baseModuleList[baseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex].multiplier, !moduleMultiplier.isEmpty {
                            multiplierMap[moduleMultiplier] = true
                        }
                        
                        for featureIndex in baseModuleList[baseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex].features.indices {
                            if let featureMultiplier = baseModuleList[baseModuleIndex].moduleGroups[moduleGroupIndex].modules[moduleIndex].features[featureIndex].multiplier, !featureMultiplier.isEmpty {
                                multiplierMap[featureMultiplier] = true
                            }
                        }
                    }
                }
                
                if let baseModuleCode = baseModuleList[baseModuleIndex].code, !baseModuleCode.isEmpty {
                    baseMultiplierMap[baseModuleCode] = multiplierMap
                }
            }
            responsibleMultipliersOfBaseModules = baseMultiplierMap
        }
    }
    
    private func prepareMultiplierLabels(baseModuleIndex: Int) {
        for multiplierIndex in baseModuleList[baseModuleIndex].multipliers.indices {
            let multiplier = baseModuleList[baseModuleIndex].multipliers[multiplierIndex]
            
            var slabLabelList: [String] = []
            if multiplier.slabConfig?.inputType == "slider" {
                continue
            }
            
            for (index, slab) in multiplier.slabs.enumerated() {
                let regex = NSRegularExpression(#"^[0-9]+(?:[.,][0-9]+)*$"#)
                let isNumber = regex.matches(in: slab)
                
                if isNumber {
                    if multiplier.slabConfig?.showRange == true {
                        let slabText = multiplier.slabTexts.count > index ? multiplier.slabTexts[index] : ""
                        let increment = 1
                        
                        let itemValue = Int(Double(slab) ?? 0.0)
                        
                        var startItem = increment
                        if index > 0 {
                            startItem = Int(Double(multiplier.slabs[index-1]) ?? 0.0) + increment
                        }
                        
                        let slabLabel = slabText.isEmpty ? "\(startItem)-\(itemValue)" : "\(slabText)(\(startItem)-\(itemValue))"
                        slabLabelList.append(slabLabel)
                    } else {
                        let slabText = multiplier.slabTexts.count > index ? multiplier.slabTexts[index] : ""
                        
                        let itemValue = Int(Double(slab) ?? 0.0)
                        
                        let slabLabel = slabText.isEmpty ? "\(itemValue)" : "\(slabText)(\(itemValue))"
                        slabLabelList.append(slabLabel)
                    }
                } else {
                    slabLabelList.append(slab)
                }
            }
            baseModuleList[baseModuleIndex].multipliers[multiplierIndex].slabLabels = slabLabelList
        }
    }
    
    func calculateSummaryCost(moduleCost: Int) {
        let users = ceil((Double(moduleCost) / Double(AppConstants.perUserCost)))
        let totalUsers = Int(users)
        
        if totalUsers <= AppConstants.additionalUsers {
            additionalUsers = AppConstants.additionalUsers - totalUsers
        } else {
            additionalUsers = 0
        }
        usersIncluded = totalUsers
        costAdditionalUsers = (AppConstants.costAdditionalUsers / AppConstants.additionalUsers) * additionalUsers
        
        costSoftwareLicense = moduleCost + costAdditionalUsers

        costRequirementAnalysis = (costSoftwareLicense * AppConstants.percentRequirementAnalysis) / 100
        costDeployment = (costSoftwareLicense * AppConstants.percentDeployment) / 100
        costOnsiteAdoptionSupport = (costSoftwareLicense * AppConstants.percentOnSiteAdoption) / 100
        costConfiguration = (costSoftwareLicense * AppConstants.percentConfiguration) / 100
        costTraining = (costSoftwareLicense * AppConstants.percentTraining) / 100
        costProjectManagement = (costSoftwareLicense * AppConstants.percentProjectManagement) / 100
        
        costImplementation = costRequirementAnalysis +
                costDeployment + costConfiguration +
                costOnsiteAdoptionSupport +
                costTraining + costProjectManagement

        costSoftwareCustomizationTotal = costSoftwareCustomization + costCustomizedReport

        costConsultancy = (costSoftwareLicense * AppConstants.percentConsultancy) / 100

        costConsultancyServices = costConsultancy

        costAnnualMaintenance = (costSoftwareLicense * AppConstants.percentMaintenance) / 100

        costAnnualMaintenanceTotal = costAnnualMaintenance

        costTotal = costSoftwareLicense + costImplementation + costSoftwareCustomizationTotal + costConsultancyServices + costAnnualMaintenanceTotal
    }
    
    func submitOrUpdateSummary() {
        let maintenance = SummaryResponseAdditionalService(
            summeryid: nil,
            header: "Annual Maintenance Cost",
            total: costAnnualMaintenanceTotal,
            discount: 0,
            modules: [
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costAnnualMaintenance,
                    discount: 0,
                    details: "",
                    name: "Annual Maintenance Cost",
                    details_value: 0,
                    details_multiplier: 0,
                    Table: ""
                )
            ],
            Table: ""
        )
        
        let consultancy = SummaryResponseAdditionalService(
            summeryid: nil,
            header: "Consultancy Services",
            total: costConsultancyServices,
            discount: 0,
            modules: [
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costConsultancy,
                    discount: 0,
                    details: "man-days x ৳",
                    name: "Consultancy",
                    details_value: 0,
                    details_multiplier: 20000,
                    Table: ""
                )
            ],
            Table: ""
        )
        
        let customization = SummaryResponseAdditionalService(
            summeryid: nil,
            header: "Software Customization",
            total: costSoftwareCustomizationTotal,
            discount: 0,
            modules: [
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costSoftwareCustomization,
                    discount: 0,
                    details: "man-days x ৳",
                    name: "Software Customization",
                    details_value: costSoftwareCustomization / AppConstants.unitPriceSoftwareCustomization,
                    details_multiplier: AppConstants.unitPriceSoftwareCustomization,
                    Table: ""
                ),
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costCustomizedReport,
                    discount: 0,
                    details: "man-days x ৳",
                    name: "Customized Report",
                    details_value: costCustomizedReport / AppConstants.unitPriceCustomizedReports,
                    details_multiplier: AppConstants.unitPriceCustomizedReports,
                    Table: ""
                )
            ],
            Table: ""
        )
        
        let implementation = SummaryResponseAdditionalService(
            summeryid: nil,
            header: "Implementation",
            total: costImplementation,
            discount: 0,
            modules: [
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costRequirementAnalysis,
                    discount: 0,
                    details: "man-days x ৳",
                    name: "Requirement Analysis",
                    details_value: 0,
                    details_multiplier: 10000,
                    Table: ""
                ),
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costImplementation,
                    discount: 0,
                    details: "(onetime) x ৳",
                    name: "Deployment",
                    details_value: 1,
                    details_multiplier: 10000,
                    Table: ""
                ),
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costConfiguration,
                    discount: 0,
                    details: "man-days x ৳",
                    name: "Configuration",
                    details_value: 0,
                    details_multiplier: 10000,
                    Table: ""
                ),
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costOnsiteAdoptionSupport,
                    discount: 0,
                    details: "man-days x ৳",
                    name: "Onsite Adoption Support",
                    details_value: 0,
                    details_multiplier: 6000,
                    Table: ""
                ),
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costTraining,
                    discount: 0,
                    details: "sessions x ৳",
                    name: "Training",
                    details_value: 0,
                    details_multiplier: 6000,
                    Table: ""
                ),
                SummaryResponseAdditionalServiceModule(
                    summeryid: nil,
                    totalamount: costProjectManagement,
                    discount: 0,
                    details: "man-days x ৳",
                    name: "Project Management",
                    details_value: 0,
                    details_multiplier: 1200,
                    Table: ""
                )
            ],
            Table: ""
        )
        
        var totalAmount = (consultancy.total ?? 0) + (customization.total ?? 0) + (implementation.total ?? 0) // + (maintenance.totalamount ?? 0)
        
        var softwareLicenseModuleList: [SummaryResponseSoftwareLicenseModule] = []
        
        for key in softwareLicenseModuleMap.keys {
            if let softwareLicenseModule = softwareLicenseModuleMap[key] {
                softwareLicenseModuleList.append(softwareLicenseModule)
                totalAmount += softwareLicenseModule.totalamount ?? 0
            }
        }
        
        let summarySoftwareLicense = SummaryResponseSoftwareLicense(summeryid: nil, header: "Software License",
                                                                    totalamount: totalAmount, discount: 0,
                                                                    users: usersIncluded, additionalusers: additionalUsers,
                                                                    modules: softwareLicenseModuleList,
                                                                    Table: "")
        
        if var quotation = self.quotationDetails {
            quotation.totalamount = totalAmount
            quotation.Software_License = summarySoftwareLicense
            quotation.Implementation = implementation
            quotation.Customization = customization
            quotation.Consultancy = consultancy
            quotation.Maintainance = maintenance
            updateQuotation(quotationUpdateBody: quotation)
        } else {
            let summaryStoreBody = SummaryStoreModel(salesmanid: UserSessionManager.userAccount?.salesmanid,
                                                     customerid: UserSessionManager.userAccount?.id, details: false,
                                                     header: "Summery", productid: "prismerp",
                                                     totalamount: totalAmount, Software_License: summarySoftwareLicense,
                                                     Implementation: implementation, Customization: customization,
                                                     Consultancy: consultancy, Maintainance: maintenance, company: "RTC Hubs")
            submitQuotation(quotationStoreBody: summaryStoreBody)
        }
    }
    
    func calculateModulePrice(module: inout ServiceModule, with index: Int, customValue: String) {
        
        if index == -1 {
            module.defaultprice = Double(customValue) ?? 0.0
            return
        }
        
        if module.price.count <= index {
            return
        }
        
        let price = module.price[index]
        if price.isEmpty {
            return
        }
        
        module.defaultprice = Double(price) ?? 0.0
    }
    
    func calculateFeaturePrice(feature: inout Feature, with index: Int, customValue: String) {
        if index == -1 {
            feature.defaultprice = Double(customValue) ?? 0.0
            return
        }
        
        if feature.price.count <= index {
            return
        }
        
        let price = feature.price[index]
        if price.isEmpty {
            return
        }
        
        feature.defaultprice = Double(price) ?? 0.0
    }
}
