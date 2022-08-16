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
    let Software_License: SummarySoftwareLicense?
    let Implementation: SummaryService?
    let Customization: SummaryService?
    let Consultancy: SummaryService?
    let Maintainance: SummaryService?
    let company: String?
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
    let licensingparameters: [LicensingParameter]
    let features: [SummaryModuleFeature]
}

// MARK: - SummaryModuleFeature
struct SummaryModuleFeature: Codable {
    let name: String?
    let code: String?
    let multiplier: String?
    let multipliercode: String?
    let price: [String]
    let type: String?
    let defaultprice: Int?
    let totalamount: Int?
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
    let details_value: Int?
    let details_multiplier: Int?
    let totalamount: Int?
}

// MARK: - LicensingParameter
struct LicensingParameter: Codable {
    let name: String?
    let value: String?
    let slabid: Int?
}




