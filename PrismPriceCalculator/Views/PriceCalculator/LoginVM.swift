//
//  LoginVM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import Foundation
import Combine

class LoginVM: NSObject, ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
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
