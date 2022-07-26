//
//  ServiceCustomizationView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/14/22.
//

import SwiftUI

struct ServiceCustomizationView: View {
    @EnvironmentObject var appGlobalState: AppState
    @State private var isShowingDetailView = false
    @State private var selectedTag: Int? = -1
    
    var body: some View {
        VStack {
            NavigationLink(destination: LoginView(), tag: 3, selection: self.$selectedTag) {
                EmptyView()
            }.isDetailLink(false)
            
            NavigationLink(destination: PriceCalculatorView(), tag: 4, selection: self.$selectedTag) {
                EmptyView()
            }
            VStack(alignment: .leading, spacing: 16) {
                Text("CUSTOM")
                    .foregroundColor(Color("textColor3"))
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                
                Divider()
                
                Text("Pick modules that are suitable for your needs")
                    .foregroundColor(Color("textColor2"))
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
                
                Button(action: {
                    self.selectedTag = 4
                }) {
                    HStack {
                        Spacer()
                        Text("CUSTOMIZE")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 15)
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 5, style: .circular).fill(Color("blue1")))
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
            .background(.white)
            .clipped()
            .cornerRadius(5)
            .shadow(color: Color("shadowColor"), radius: 5)
            .padding(.horizontal, 16)
            Spacer()
        }
        .navigationTitle("Customization")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if UserSessionManager.isLoggedIn {
                        UserSessionManager.logout()
                        appGlobalState.isLoggedIn = false
                        selectedTag = -1
                    } else {
                        selectedTag = 3
                    }
                }) {
                    Text(appGlobalState.isLoggedIn ? "LOGOUT" : "LOGIN")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color("blue1"))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .circular)
                                .stroke(Color("blue1"), lineWidth: 1)
                        )
                }
            }
        }
    }
}

struct ServiceCustomizationView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceCustomizationView().environmentObject(AppState())
    }
}
