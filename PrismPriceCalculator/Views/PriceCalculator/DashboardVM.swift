//
//  DashboardVM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/13/22.
//

import Foundation
import Combine

class DashboardVM: BaseViewModel {
    var allProductsListPublisher = PassthroughSubject<[ServiceProduct], Never>()
    private var loadAllProductSubscriber: AnyCancellable? = nil
    
    deinit {
        loadAllProductSubscriber?.cancel()
    }
    
    func loadAllProducts() {
        self.loadAllProductSubscriber = ApiService.allProducts(viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { response in
                if response.code == 2000001 {
                    guard let products = response.data?.products else {
                        return
                    }
                    self.allProductsListPublisher.send(products)
                } else {
                    self.errorToastPublisher.send((true, response.msg ?? "Failed! please try again later"))
                }
            })
    }
}
