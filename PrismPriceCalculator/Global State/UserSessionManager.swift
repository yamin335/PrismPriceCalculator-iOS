//
//  UserSessionManager.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/18/22.
//

import Foundation

class UserSessionManager {
    private static let userDefault = UserDefaults.standard
    
    static var isLoggedIn: Bool {
        set {
            userDefault.set(newValue, forKey: AppConstants.keyIsLoggedIn)
        }
        
        get {
            return userDefault.bool(forKey: AppConstants.keyIsLoggedIn)
        }
    }
    
    static var loginToken: LoginToken? {
        set {
            if let newValue = newValue, let encodedData = try? JSONEncoder().encode(newValue) {
                userDefault.set(encodedData, forKey: AppConstants.keyLoginToken)
            }
        }
        
        get {
            var loginToken: LoginToken? = nil
            if let tokenData = userDefault.object(forKey: AppConstants.keyLoginToken) as? Data {
                if let decodedLoginToken = try? JSONDecoder().decode(LoginToken.self, from: tokenData) {
                    loginToken = decodedLoginToken
                }
            }
            return loginToken
        }
    }
    
    static var userAccount: UserAccount? {
        set {
            if let newValue = newValue, let encodedData = try? JSONEncoder().encode(newValue) {
                userDefault.set(encodedData, forKey: AppConstants.keyUserAccount)
            }
        }
        
        get {
            var userAccount: UserAccount? = nil
            if let userData = userDefault.object(forKey: AppConstants.keyUserAccount) as? Data {
                if let decodedUserData = try? JSONDecoder().decode(UserAccount.self, from: userData) {
                    userAccount = decodedUserData
                }
            }
            return userAccount
        }
    }
    
    static func logout() {
        isLoggedIn = false
    }
}
