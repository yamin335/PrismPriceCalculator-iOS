//
//  SignUpModels.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/18/22.
//

import Foundation

struct SignUpResponse: Codable {
    let code: Int?
    let data: SignUpResponseData?
    let msg: String?
}

struct SignUpResponseData: Codable {
    let Account: UserAccount?
}
