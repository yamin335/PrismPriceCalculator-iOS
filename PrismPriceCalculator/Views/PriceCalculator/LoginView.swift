//
//  LoginView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginVM()
    @State private var loginButtonDisabled = true
    @State private var isShowingSignUpView = false
    
    var body: some View {
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
        .navigationTitle("Sign In")
        .onReceive(self.viewModel.validatedCredentials) { validCredential in
            self.loginButtonDisabled = !validCredential
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
