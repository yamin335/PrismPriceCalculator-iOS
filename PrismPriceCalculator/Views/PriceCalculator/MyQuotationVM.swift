//
//  MyQuotationVM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 9/14/22.
//

import Foundation

import Foundation
import Combine

class MyQuotationVM: BaseViewModel {
    var myQuotationListPublisher = PassthroughSubject<[MyQuotation], Never>()
    private var loadMyQuotationSubscriber: AnyCancellable? = nil
    
    deinit {
        loadMyQuotationSubscriber?.cancel()
    }
    
    func loadMyQuotationList(email: String, page: String) {
        self.loadMyQuotationSubscriber = ApiService.myQuotations(email: email, page: page, viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { response in
                if response.code == 2000001 {
                    guard let quotations = response.data?.quotations else {
                        return
                    }
                    self.myQuotationListPublisher.send(quotations)
                } else {
                    self.errorToastPublisher.send((true, response.msg ?? "Failed! please try again later"))
                }
            })
    }
}
