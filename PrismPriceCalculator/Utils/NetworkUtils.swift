//
//  NetworkUtils.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/18/22.
//

import Foundation

class NetworkUtils {
    static let baseUrl = "https://prismerpbackend.rtchubs.com"
    private static let apiVersion = "v1"
    private static let authRepo = "auth"
    private static let productRepo = "product"
    
    static let login = "\(baseUrl)/\(apiVersion)/\(authRepo)/login"
    static let signUp = "\(baseUrl)/\(apiVersion)/\(authRepo)/registercustomer"
    static let submitQuotation = "\(baseUrl)/\(apiVersion)/quotation/submit"
    static let allProducts = "\(baseUrl)/\(apiVersion)/\(productRepo)/allactive"
    static let productDetails = "\(baseUrl)/\(apiVersion)/\(productRepo)/json"
    
    static func getCommonUrlRequest(url: URL) -> URLRequest {
        //Request type
        var request = URLRequest(url: url)
        //Setting common headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let loggedUser = UserLocalStorage.getUserCredentials().loggedUser
//        request.setValue(loggedUser?.ispToken ?? "", forHTTPHeaderField: "AuthorizedToken")
//        let userId = loggedUser?.userID ?? 0
//        request.setValue(String(userId), forHTTPHeaderField: "userId")
//        request.setValue("3", forHTTPHeaderField: "platformId")
        
        return request
    }
}
