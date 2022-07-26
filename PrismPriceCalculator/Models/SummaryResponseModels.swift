//
//  SummaryResponseModels.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/20/22.
//

import Foundation

// MARK: - SummaryResponse
struct SummaryResponse: Codable {
    let code: Int?
    let data: SummaryResponseData?
    let msg: String?
}

// MARK: - SummaryResponseData
struct SummaryResponseData: Codable {
    let quotation: SummaryResponseQuotation?
}

// MARK: - SummaryResponseQuotation
struct SummaryResponseQuotation: Codable {
    let id: Int?
    let status: String?
    let ishistory: Bool?
    let quotationhid, header: String?
    let customerid, salesmanid: Int?
    let quotationid, productid: String?
    let totalamount, discount: Int?
    let softwareLicense: SummaryResponseSoftwareLicense?
    let implementation, customization, consultancy, maintainance: SummaryResponseConsultancy?
    let table: String?
}

// MARK: - SummaryResponseConsultancy
struct SummaryResponseConsultancy: Codable {
    let summeryid, header: String?
    let total, discount: Int?
    let modules: [SummaryResponseConsultancyModule]
    let table: String?
}

// MARK: - SummaryResponseConsultancyModule
struct SummaryResponseConsultancyModule: Codable {
    let summeryid: String?
    let totalamount, discount: Int?
    let name, details: String?
    let detailsValue, detailsMultiplier: Int?
    let table: String?
}

// MARK: - SummaryResponseSoftwareLicense
struct SummaryResponseSoftwareLicense: Codable {
    let summeryid, header: String?
    let totalamount, discount, users, additionalusers: Int?
    let modules: [SummaryResponseSoftwareLicenseModule]
    let table: String?
}

// MARK: - SummaryResponseSoftwareLicenseModule
struct SummaryResponseSoftwareLicenseModule: Codable {
    let name, code, selfcode: String?
    let price, totalamount, discount: Int?
    let features: [SummaryResponseFeature]
}

// MARK: - SummaryResponseFeature
struct SummaryResponseFeature: Codable {
    let name, code, parentcode, featureDescription: String?
    let multipliercode: String?
    let type: String?
    let discount, price: Int?
}
