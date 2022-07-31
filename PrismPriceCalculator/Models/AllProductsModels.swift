//
//  AllProductsModels.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/31/22.
//

import Foundation

// MARK: - Welcome
struct AllProductsResponse: Codable {
    let code: Int?
    let data: AllProductsResponseData?
    let msg: String?
}

// MARK: - DataClass
struct AllProductsResponseData: Codable {
    let products: [ServiceProduct]
}

// MARK: - Product
struct ServiceProduct: Codable {
    let id: String?
    let name: String?
    let logo: String?
    let title: String?
    let description: String?
    let sheetlink: String?
    let productdetailslink: String?
    let isactive: Bool?
    let price: Int?
    let Table: String?
}
