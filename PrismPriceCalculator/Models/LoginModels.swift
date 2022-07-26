//
//  LoginModels.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/18/22.
//

import Foundation

struct UserAccount: Codable {
    let id: Int?
    let email: String?
    let type: String?
    let role: String?
    let fullname: String?
    let mobile: String?
    let company: String?
    let gender: String?
    let salesmanid: Int?
    let Table: String?
    let password: String?
    let retypepassword: String?
}

struct LoginResponse: Codable {
    let code: Int?
    let data: LoginResponseData?
    let msg: String?
}

struct LoginResponseData: Codable {
    let Account: UserAccount?
    let Token: LoginToken?
}

struct LoginToken: Codable {
    let AccessToken: String?
    let RefreshToken: String?
    let AccessUUID: String?
    let RefreshUUID: String?
    let AtExpires: UInt64?
    let RtExpires: UInt64?
}
