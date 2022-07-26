//
//  SignUpVM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import Foundation
import Combine

class SignUpVM: BaseViewModel {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var companyName: String = ""
    @Published var mobileNumber: String = ""
    @Published var password: String = ""
    @Published var reTypePassword: String = ""
    
    var signUpStatusPublisher = PassthroughSubject<Bool, Never>()
    private var signUpSubscriber: AnyCancellable? = nil
    
    deinit {
        signUpSubscriber?.cancel()
    }
        
    var isValidEmail: AnyPublisher<Bool, Never> {
        return $email
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                let regexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
                let range = email.range(of: regexPattern, options: .regularExpression)
                
                guard !email.isEmpty, range != nil else {
                    return false
                }
                return true
        }
        .eraseToAnyPublisher()
    }
    
    var isValidPasswod: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($password, $reTypePassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .receive(on: RunLoop.main) // <<—— run on main thread
            .map { password, reTypePassword in
                guard !password.isEmpty, !reTypePassword.isEmpty, password == reTypePassword else { return false }
                return true
        }
        .eraseToAnyPublisher()
    }
    
    var isValidMobileNumber: AnyPublisher<Bool, Never> {
        return $mobileNumber
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { mobile in
                let regexPattern = "^(?=\\d)\\d{11}(?!\\d)"
                let range = mobile.range(of: regexPattern, options: .regularExpression)
                
                guard !mobile.isEmpty, range != nil else {
                    return false
                }
                return true
        }
        .eraseToAnyPublisher()
    }
    
    var isSignupFormValid: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($firstName, $lastName, $companyName)
            .receive(on: RunLoop.main) // <<—— run on main thread
            .map { firstName, lastName, companyName in
                guard !firstName.isEmpty, !lastName.isEmpty, !companyName.isEmpty else {
                    return false
                }
                return true

            }
            .eraseToAnyPublisher()
    }
    
    var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest4(isValidEmail, isValidPasswod, isValidMobileNumber, isSignupFormValid)
            .receive(on: RunLoop.main) // <<—— run on main thread
            .map { isValidEmail, isValidPasswod, isValidMobileNumber, isSignupFormValid in
                if isValidEmail && isValidPasswod && isValidMobileNumber && isSignupFormValid {
                    return true
                } else {
                    return false
                }
        }
        .eraseToAnyPublisher()
    }
    
    func signUp() {
        self.signUpSubscriber = ApiService.signUp(userName: "\(firstName)\(lastName)", password: password, email: email, userType: 3, firstName: firstName, lastName: lastName, company: companyName, mobile: mobileNumber, reTypePassword: reTypePassword, fullName: "\(firstName) \(lastName)", type: "customer", role: "customer", viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { signUpResponse in
                if signUpResponse.code == 2000001 {
                    self.successToastPublisher.send((true, signUpResponse.msg ?? "Account created successfully!"))
                    self.signUpStatusPublisher.send(true)
                } else {
                    self.errorToastPublisher.send((true, signUpResponse.msg ?? "Sign Up failed! please try again later"))
                }
            })
    }
}
