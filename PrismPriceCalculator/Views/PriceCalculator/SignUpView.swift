//
//  SignUpView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = SignUpVM()
    @State private var signUpButtonDisabled = true
    
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
    @State private var showLoader = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        Text("If you already have an account, please")
                            .foregroundColor(.gray).font(.subheadline)
                        Button(action: {
                            withAnimation() {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Sign In")
                                .foregroundColor(Color("blue1"))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    
                    Group {
                        TextField("First Name", text: $viewModel.firstName)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        TextField("Last Name", text: $viewModel.lastName)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        TextField("Email", text: $viewModel.email)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        TextField("Company Name", text: $viewModel.companyName)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        TextField("Mobile Number", text: $viewModel.mobileNumber)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                    
                    SecureField("Re-Type Password", text: $viewModel.reTypePassword)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .overlay(RoundedRectangle(cornerRadius: 5) .stroke(Color("blue1")) )
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                    
                    Button(action: {
                        self.viewModel.signUp()
                    }) {
                        HStack {
                            Spacer()
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(signUpButtonDisabled ? Color("gray5") : .white)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 15)
                            Spacer()
                        }
                        .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color("blue1")))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                    .padding(.bottom, 20)
                    .disabled(signUpButtonDisabled)
                    
                    Spacer()
                    
                    Text("All rights reserved. Copyright ©2022, Divine IT Ltd.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                }
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
        .navigationTitle("Create Your Account")
        .onReceive(self.viewModel.validatedCredentials) { validCredential in
            self.signUpButtonDisabled = !validCredential
        }
        .onReceive(self.viewModel.signUpStatusPublisher.receive(on: RunLoop.main)) { isAccountCreated in
            if isAccountCreated {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation() {
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
