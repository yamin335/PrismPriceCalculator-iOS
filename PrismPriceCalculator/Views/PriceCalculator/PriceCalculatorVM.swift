//
//  PriceCalculatorVM.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation
import Combine

class PriceCalculatorVM: BaseViewModel {
    var baseModuleListPublisher = PassthroughSubject<[ServiceModule], Never>()
    var shouldCalculateData = PassthroughSubject<Bool, Never>()
    var calculateSelectedModuleFor = PassthroughSubject<String, Never>()
    
    private var submitQuotationSubscriber: AnyCancellable? = nil
    var quotationStatusPublisher = PassthroughSubject<Bool, Never>()
    
    var submitEnableDisablePublisher = PassthroughSubject<Bool, Never>()
    
//    // MARK: Header START
//    var branches = [
//        ChipsDataModel(label: "1 - 1", isSelected: true),
//        ChipsDataModel(label: "2 - 4", isSelected: false),
//        ChipsDataModel(label: "5 - 8", isSelected: false),
//        ChipsDataModel(label: "Custom", isSelected: false)
//    ]
//    
//    var products = [
//        ChipsDataModel(label: "1 - 100", isSelected: true),
//        ChipsDataModel(label: "101 - 500", isSelected: false),
//        ChipsDataModel(label: "501 - 1500", isSelected: false)
//    ]
//    
//    var businessType = [
//        ChipsDataModel(label: "Manufacturing", isSelected: true),
//        ChipsDataModel(label: "Trading", isSelected: false),
//        ChipsDataModel(label: "Service", isSelected: false),
//        ChipsDataModel(label: "Mixed", isSelected: false)
//    ]
//    
//    // MARK: Header FMS
//    var accounts = [
//        ChipsDataModel(label: "Small (1-400)", isSelected: true),
//        ChipsDataModel(label: "Medium (401-800)", isSelected: false),
//        ChipsDataModel(label: "Large (801-1200)", isSelected: false)
//    ]
//    
//    var customers = [
//        ChipsDataModel(label: "Small (1-500)", isSelected: true),
//        ChipsDataModel(label: "Medium (501-2000)", isSelected: false),
//        ChipsDataModel(label: "Large (2001-5000)", isSelected: false)
//    ]
//    
//    var vendors = [
//        ChipsDataModel(label: "Small (1-500)", isSelected: true),
//        ChipsDataModel(label: "Medium (501-2000)", isSelected: false),
//        ChipsDataModel(label: "Large (2001-5000)", isSelected: false)
//    ]
//    
//    // MARK: Header HCM
//    var employees = [
//        ChipsDataModel(label: "1 - 50", isSelected: true),
//        ChipsDataModel(label: "51 - 100", isSelected: false),
//        ChipsDataModel(label: "101 - 200", isSelected: false),
//        ChipsDataModel(label: "201 - 500", isSelected: false),
//        ChipsDataModel(label: "501 - 1000", isSelected: false),
//        ChipsDataModel(label: "1001 - 5000", isSelected: false),
//        ChipsDataModel(label: "5001 - 10000", isSelected: false)
//    ]
//    
//    var attendanceDevices = [
//        ChipsDataModel(label: "1", isSelected: true),
//        ChipsDataModel(label: "2", isSelected: false),
//        ChipsDataModel(label: "3", isSelected: false),
//        ChipsDataModel(label: "4", isSelected: false),
//        ChipsDataModel(label: "5", isSelected: false),
//        ChipsDataModel(label: "6", isSelected: false),
//        ChipsDataModel(label: "7", isSelected: false),
//        ChipsDataModel(label: "Custom", isSelected: false)
//    ]
//    
//    // MARK: Header PPC
//    var industryType = [
//        ChipsDataModel(label: "1", isSelected: false),
//        ChipsDataModel(label: "2", isSelected: false),
//        ChipsDataModel(label: "3", isSelected: false)
//    ]
//    
//    var productionUnits = [
//        ChipsDataModel(label: "1", isSelected: false),
//        ChipsDataModel(label: "2", isSelected: false),
//        ChipsDataModel(label: "3", isSelected: false),
//        ChipsDataModel(label: "10", isSelected: false)
//    ]
//    
//    var lineOrMachine = [
//        ChipsDataModel(label: "5", isSelected: false),
//        ChipsDataModel(label: "10", isSelected: false),
//        ChipsDataModel(label: "20", isSelected: false),
//        ChipsDataModel(label: "50", isSelected: false)
//    ]
//    
//    var typeOfFinishedGoods = [
//        ChipsDataModel(label: "1 - 10", isSelected: false),
//        ChipsDataModel(label: "11 - 50", isSelected: false),
//        ChipsDataModel(label: "51 - 200", isSelected: false),
//        ChipsDataModel(label: "201 - 500", isSelected: false)
//    ]
//    
//    // MARK: Header EAM
//    var serials = [
//        ChipsDataModel(label: "1 - 5000", isSelected: false),
//        ChipsDataModel(label: "5001 - 20000", isSelected: false),
//        ChipsDataModel(label: "20001 - 100000", isSelected: false)
//    ]
//    
//    // MARK: Header CSC
//    var users = [
//        ChipsDataModel(label: "1 - 5", isSelected: false),
//        ChipsDataModel(label: "6 - 10", isSelected: false),
//        ChipsDataModel(label: "11 - 25", isSelected: false),
//        ChipsDataModel(label: "26 - 50", isSelected: false),
//        ChipsDataModel(label: "51 - 100", isSelected: false),
//        ChipsDataModel(label: "11 - 150", isSelected: false),
//        ChipsDataModel(label: "151 - 200", isSelected: false),
//        ChipsDataModel(label: "201 - 300", isSelected: false)
//    ]
//    
//    // MARK: Header PPC
//    var temp = [
//        ChipsDataModel(label: "200", isSelected: false),
//        ChipsDataModel(label: "200", isSelected: false),
//        ChipsDataModel(label: "200", isSelected: false),
//        ChipsDataModel(label: "200", isSelected: false),
//        ChipsDataModel(label: "200", isSelected: false)
//    ]
    
    var softwareLicenseModuleList: [SoftwareLicenseModule] = []
    var softwareLicenseModuleMap: [String : SoftwareLicenseModule] = [:]
    
    deinit {
        submitQuotationSubscriber?.cancel()
    }
    
    func loadAllModuleData() {
        guard let url = Bundle.main.url(forResource: "divine", withExtension: "json") else {
            print("Json file not found")
            return
        }
        
        guard let data = try? Data(contentsOf: url),
        let list = try? JSONDecoder().decode([ServiceModule].self, from: data) else {
            print("Json file parsing failed!")
            return
        }
        
        var baseModuleList = list
        
        for baseModuleIndex in 0..<baseModuleList.count {
            for moduleGroupIndex in 0..<baseModuleList[baseModuleIndex].moduleGroups.count {
                baseModuleList[baseModuleIndex].moduleGroups[moduleGroupIndex].numberOfSelectedModule = 0
            }
        }
        baseModuleListPublisher.send(baseModuleList)
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
}
