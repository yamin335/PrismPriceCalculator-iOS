//
//  SignUpVM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import Foundation
import Combine

class SignUpVM: NSObject, ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var companyName: String = ""
    @Published var mobileNumber: String = ""
    @Published var password: String = ""
    @Published var reTypePassword: String = ""
    
    var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($email, $password)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .receive(on: RunLoop.main) // <<—— run on main thread
            .map { email, password in
                guard !email.isEmpty, !password.isEmpty else { return false }
                return true
        }
        .eraseToAnyPublisher()
    }
}
