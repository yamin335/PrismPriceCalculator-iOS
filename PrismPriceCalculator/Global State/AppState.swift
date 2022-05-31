//
//  AppState.swift
//  itsgood
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    
    enum AppDeployment: String {
        case production = "Production"
        case qa         = "QA"
    }
    
    #if DEVELOPMENT
    @Published var deploymentBuild: AppDeployment = .qa
    #else
    @Published var deploymentBuild: AppDeployment = .production
    #endif
    
    @Published var phoneNumberPrettified: String {
        didSet {
            UserDefaults.standard.set(phoneNumberPrettified, forKey: "phone_number_prettified")
        }
    }
    
    @Published var phoneNumber: String? {
        didSet {
            UserDefaults.standard.set(phoneNumber, forKey: "phone_number")
        }
    }
    
    @Published var accessToken: String? {
        didSet {
            if accessToken == nil {
                UserDefaults.standard.removeObject(forKey: "access_token")
            } else {
                UserDefaults.standard.set(accessToken, forKey: "access_token")
            }
        }
    }
    
    @Published var id: String? {
        didSet {
            UserDefaults.standard.set(id, forKey: "id")
        }
    }
    
    @Published var email: String? {
        didSet {
            UserDefaults.standard.set(email, forKey: "email")
        }
    }
    
    @Published var firstName: String? {
        didSet {
            UserDefaults.standard.set(firstName, forKey: "first_name")
        }
    }
    
    @Published var lastName: String? {
        didSet {
            UserDefaults.standard.set(lastName, forKey: "last_name")
        }
    }
    
    @Published var username: String? {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var picture: String? {
        didSet {
            UserDefaults.standard.set(picture, forKey: "picture")
        }
    }
    
    @Published var active: Bool {
        didSet {
            UserDefaults.standard.set(active, forKey: "active")
        }
    }
    @Published var isLoggingIn: Bool {
        didSet {
            UserDefaults.standard.set(active, forKey: "isLoggingIn")
        }
    }
    
    @Published var isShowingErrorText: Bool = false
    @Published var isShowingErrorFromServer: Bool = false
    @Published var errorMessage: String = ""
    let locale = Locale.current
    @Published var countryPhoneCode = ""
    @Published var isShowingOnboardingModal = false
    @Published var isLoggedOut = false
    @Published var isShowingCreateListModal: Bool = false
        
    init() {
    
        self.phoneNumberPrettified = UserDefaults.standard.string(forKey: "phone_number_prettified") ?? ""
        self.phoneNumber = UserDefaults.standard.string(forKey: "phone_number") ?? ""
        self.accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        self.id = UserDefaults.standard.string(forKey: "id") ?? ""
        self.email = UserDefaults.standard.string(forKey: "email") ?? ""
        self.firstName = UserDefaults.standard.string(forKey: "first_name") ?? ""
        self.lastName = UserDefaults.standard.string(forKey: "last_name") ?? ""
        self.username = UserDefaults.standard.string(forKey: "username") ?? ""
        self.picture = UserDefaults.standard.string(forKey: "picture") ?? ""
        self.active = (UserDefaults.standard.object(forKey: "active") != nil)
        self.isLoggingIn = (UserDefaults.standard.object(forKey: "isLoggingIn") != nil)
        self.isShowingCreateListModal = false
    }
    
}
