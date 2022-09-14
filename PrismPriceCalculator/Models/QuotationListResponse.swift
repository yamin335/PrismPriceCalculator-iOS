//
//  QuotationListResponse.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 9/14/22.
//

import Foundation

struct QuotationListResponse: Codable {
    let code: Int?
    let data: QuotationListResponseData?
    let msg: String?
}

struct QuotationListResponseData: Codable {
    let pagination: PaginationData?
    let quotations: [MyQuotation]?
}

struct PaginationData: Codable {
    let total_page: Int?
    let offset: Int?
    let limit: Int?
    let page: Int?
}

struct MyQuotation: Codable {
    let quotationid: String?
    let productid: String?
    let customerid: String?
    let salesmanid: Int?
    let customername: String?
    let status: String?
    let totalamount: Int?
    let discount: Int?
    let company: String?
    let customercompany: String?
    let customermobile: String?
    let date: String?
}
