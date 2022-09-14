//
//  SummaryModels.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/19/22.
//

import Foundation

// MARK: - SummaryStoreModel
struct SummaryStoreModel: Codable {
    let salesmanid: Int?
    let customerid: Int?
    let details: Bool?
    let header: String?
    let productid: String?
    let totalamount: Int?
    let Software_License: SummaryResponseSoftwareLicense?
    let Implementation: SummaryResponseAdditionalService?
    let Customization: SummaryResponseAdditionalService?
    let Consultancy: SummaryResponseAdditionalService?
    let Maintainance: SummaryResponseAdditionalService?
    let company: String?
}

// MARK: - LicensingParameter
struct LicensingParameter: Codable {
    let name: String?
    let value: String?
    let slabid: Int?
}




