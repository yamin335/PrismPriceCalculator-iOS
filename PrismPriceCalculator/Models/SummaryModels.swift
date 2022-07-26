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
    let header, productid: String?
    let totalamount: Int?
    let softwareLicense: SummarySoftwareLicense?
    let implementation: SummaryService?
    let customization: SummaryService?
    let consultancy: SummaryService?
    let maintainance: SummaryService?
}

// MARK: - SummarySoftwareLicense
struct SummarySoftwareLicense: Codable {
    let additionalusers: Int?
    let users: Int?
    let header: String?
    let totalamount: Int?
    let modules: [SoftwareLicenseModule]
}

// MARK: - SoftwareLicenseModule
struct SoftwareLicenseModule: Codable {
    let name: String?
    let totalamount: Int?
    let code: String?
    let features: [SummaryModuleFeature]
}

// MARK: - SummaryModuleFeature
struct SummaryModuleFeature: Codable {
    let code: String?
    let multipliercode: String?
    let price: Int?
    let type: String?
}

// MARK: - SummaryService
struct SummaryService: Codable {
    let header: String?
    let totalamount: Int?
    let modules: [SummaryServiceModule]
}

// MARK: - SummaryServiceModule
struct SummaryServiceModule: Codable {
    let name: String?
    let details: String?
    let detailsValue: Int?
    let detailsMultiplier: Int?
    let totalamount: Int?
}


