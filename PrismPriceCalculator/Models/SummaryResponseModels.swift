//
//  SummaryResponseModels.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/20/22.
//

import Foundation

// MARK: - QuotationUpdateResponse
struct QuotationUpdateResponse: Codable {
    let code: Int?
    let data: QuotationUpdateResponseData?
    let msg: String?
}


struct QuotationUpdateResponseData: Codable {
    let Quotation: SummaryResponseQuotation?
}

// MARK: - QuotationDetailsResponse
struct QuotationDetailsResponse: Codable {
    let code: Int?
    let data: QuotationDetailsResponseData?
    let msg: String?
}


struct QuotationDetailsResponseData: Codable {
    let QuotationSummary: SummaryResponseQuotation?
}

// MARK: - SummaryResponse
struct SummaryResponse: Codable {
    let code: Int?
    let data: SummaryResponseData?
    let msg: String?
}

struct SummaryResponseData: Codable {
    let quotation: SummaryResponseQuotation?
}

struct SummaryResponseQuotation: Codable {
    let id: Int?
    let status: String?
    let ishistory: Bool?
    let quotationhid: String?
    let header: String?
    let customerid: Int?
    let salesmanid: Int?
    let quotationid: String?
    let productid: String?
    let company: String?
    var totalamount: Int?
    let discount: Int?
    var Software_License: SummaryResponseSoftwareLicense?
    var Implementation: SummaryResponseAdditionalService?
    var Customization: SummaryResponseAdditionalService?
    var Consultancy: SummaryResponseAdditionalService?
    var Maintainance: SummaryResponseAdditionalService?
    let Table: String?
}

struct SummaryResponseAdditionalService: Codable {
    let summeryid: String?
    let header: String?
    let total: Int?
    let discount: Int?
    let modules: [SummaryResponseAdditionalServiceModule]
    let Table: String?
}

struct SummaryResponseAdditionalServiceModule: Codable {
    let summeryid: String?
    let totalamount: Int?
    let discount: Int?
    let details: String?
    let name: String?
    let details_value: Int?
    let details_multiplier: Int?
    let Table: String?
}

struct SummaryResponseSoftwareLicense: Codable {
    let summeryid: String?
    let header: String?
    let totalamount: Int?
    let discount: Int?
    let users: Int?
    let additionalusers: Int?
    let modules: [SummaryResponseSoftwareLicenseModule]
    let Table: String?
}

struct SummaryResponseSoftwareLicenseModule: Codable {
    let licensingparameters: [LicensingParameter]?
    let name: String?
    let code: String?
    let description: String?
    let selfcode: String?
    let defaultprice: Int?
    let totalamount: Int?
    let discount: Int?
    let features: [SummaryResponseFeature]
    let multiplier: String?
    let price: Int?
    let excludeInAll: Bool?
}

struct SummaryResponseFeature: Codable {
    let name: String?
    let code: String?
    let parentcode: String?
    let description: String?
    let multipliercode: String?
    let type: String?
    let excludeInAll: Bool?
    let discount: Int?
    let totalamount: Int?
    let multiplier: String?
    let price: [String]?
    let defaultprice: Double?
}
