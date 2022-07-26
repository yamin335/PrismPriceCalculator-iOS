//
//  DashboardVM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/13/22.
//

import Foundation
import Combine

class DashboardVM: BaseViewModel {
    var businessServiceListPublisher = PassthroughSubject<[BusinessService], Never>()
    func getBusinessServiceList() {
        businessServiceListPublisher.send(
            [BusinessService(image: "https://prismerp.rtchubs.com/img/prismerp.png",
                             description: "An ERP System to cover all business needs designed for medium and large business",
                             startingPrice: 2500000),
             BusinessService(image: "https://prismerp.rtchubs.com/img/J-Series.png",
                             description: "PrismERP J Series designed for Multi-National & Government Authorities",
                             startingPrice: 0),
             BusinessService(image: "https://prismerp.rtchubs.com/img/Onebook_zfhzCpe.png",
                             description: "Intelligent Business Assistant for Small and Medium Businesses",
                             startingPrice: 2000)]
        )
    }
    
}
