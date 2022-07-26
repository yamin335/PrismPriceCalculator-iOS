//
//  LoginView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appGlobalState: AppState
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = LoginVM()
    @State private var loginButtonDisabled = true
    @State private var isShowingSignUpView = false
    
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
    @State private var showLoader = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                TextField("Email", text: $viewModel.email)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                
                SecureField("Password", text: $viewModel.password)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                
                Button(action: {
                    viewModel.login()
                }) {
                    HStack {
                        Spacer()
                        Text("Sign In")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(loginButtonDisabled ? Color("gray5") : .white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 15)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color("blue1")))
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)
                .padding(.bottom, 20)
                .disabled(loginButtonDisabled)
                
                HStack(alignment: .center) {
                    Text("If you don't have an account yet, please")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                    Button(action: {
                        self.isShowingSignUpView = true
                    }) {
                        NavigationLink(destination: SignUpView(), isActive: $isShowingSignUpView) {
                            Text("Sign Up")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color("blue1"))
                        }
                    }
                }
                .padding(.top, 1)
                
                Spacer()
                
                Text("All rights reserved. Copyright ©2022, Divine IT Ltd.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
            }
            
            if self.showSuccessToast {
                SuccessToast(message: self.successMessage).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation() {
                            self.showSuccessToast = false
                            self.successMessage = ""
                        }
                    }
                }
            }

            if showErrorToast {
                ErrorToast(message: self.errorMessage).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation() {
                            self.showErrorToast = false
                            self.errorMessage = ""
                        }
                    }
                }
            }

            if self.showLoader {
                SpinLoaderView()
            }
        }
        .navigationTitle("Sign In")
        .onReceive(self.viewModel.validatedCredentials.receive(on: RunLoop.main)) { validCredential in
            self.loginButtonDisabled = !validCredential
        }
        .onReceive(self.viewModel.loginStatusPublisher.receive(on: RunLoop.main)) { isLoggedIn in
            if isLoggedIn {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation() {
                        self.appGlobalState.isLoggedIn = isLoggedIn
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onReceive(self.viewModel.showLoader.receive(on: RunLoop.main)) { isShowing in
            self.showLoader = isShowing
        }
        .onReceive(self.viewModel.successToastPublisher.receive(on: RunLoop.main)) {
            showToast, message in
            self.successMessage = message
            withAnimation() {
                self.showSuccessToast = showToast
            }
        }
        .onReceive(self.viewModel.errorToastPublisher.receive(on: RunLoop.main)) {
            showToast, message in
            self.errorMessage = message
            withAnimation() {
                self.showErrorToast = showToast
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppState())
    }
}
