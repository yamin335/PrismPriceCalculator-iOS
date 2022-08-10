//
//  PriceCalculatorVM.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import Foundation
import Combine

class PriceCalculatorVM: BaseViewModel {
    var baseModuleListPublisher = PassthroughSubject<[BaseServiceModule], Never>()
    var shouldCalculateData = PassthroughSubject<Bool, Never>()
    var calculateSelectedModuleFor = PassthroughSubject<String, Never>()
    
    private var submitQuotationSubscriber: AnyCancellable? = nil
    private var productDetailsSubscriber: AnyCancellable? = nil
    var quotationStatusPublisher = PassthroughSubject<Bool, Never>()
    
    var submitEnableDisablePublisher = PassthroughSubject<Bool, Never>()
    var selectedMultiplierPublisher = PassthroughSubject<(String, Int), Never>()
    
    var softwareLicenseModuleList: [SoftwareLicenseModule] = []
    var softwareLicenseModuleMap: [String : SoftwareLicenseModule] = [:]
    
    deinit {
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
                }
            }, receiveValue: { response in
                if response.code == 2000001 {
                    guard let baseModuleList = response.data?.Modules else {
                        self.errorToastPublisher.send((true, response.msg ?? "Failed! please try again later"))
                        return
                    }
                    self.baseModuleListPublisher.send(baseModuleList)
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
}
