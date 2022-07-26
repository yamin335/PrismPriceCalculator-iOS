//
//  LoginVM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import Foundation
import Combine

class LoginVM: BaseViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    
    var loginStatusPublisher = PassthroughSubject<Bool, Never>()
    private var loginSubscriber: AnyCancellable? = nil
    
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
    
    deinit {
        loginSubscriber?.cancel()
    }
    
    func login() {
        self.loginSubscriber = ApiService.login(email: email, password: password, viewModel: self)?
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorToastPublisher.send((true, error.localizedDescription))
                }
            }, receiveValue: { loginResponse in
                if loginResponse.code == 2000001 {
                    self.successToastPublisher.send((true, loginResponse.msg ?? "Login successful!"))
                    self.loginStatusPublisher.send(true)
                    UserSessionManager.isLoggedIn = true
                    UserSessionManager.loginToken = loginResponse.data?.Token
                    UserSessionManager.userAccount = loginResponse.data?.Account
                } else {
                    self.errorToastPublisher.send((true, loginResponse.msg ?? "Login failed! please try again later"))
                }
            })
    }
}
