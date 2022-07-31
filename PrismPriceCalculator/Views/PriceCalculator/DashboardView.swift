//
//  DashboardView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/13/22.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appGlobalState: AppState
    @ObservedObject var viewModel = DashboardVM()
    @State var businessServiceList: [ServiceProduct] = []
    @State private var selectedTag: Int? = -1
    
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
    @State private var showLoader = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 16) {
                    ForEach(businessServiceList, id: \.id) { product in
                        DashboardListItem(product: product)
                    }
                    
                    NavigationLink(destination: LoginView(), tag: 2, selection: self.$selectedTag) {
                        EmptyView()
                    }.isDetailLink(false)
                    
                    Spacer()
                }
                .padding(.vertical, 16)
                .navigationTitle("Prism Price Calculator")
                .onReceive(self.viewModel.allProductsListPublisher.receive(on: RunLoop.main)) { allProducts in
                    self.businessServiceList = allProducts
                }
                .onAppear {
                    self.viewModel.loadAllProducts()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if UserSessionManager.isLoggedIn {
                                UserSessionManager.logout()
                                appGlobalState.isLoggedIn = false
                                selectedTag = -1
                            } else {
                                selectedTag = 2
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
                .navigationViewStyle(StackNavigationViewStyle())
                
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
            }.onReceive(self.viewModel.showLoader.receive(on: RunLoop.main)) { isShowing in
                self.showLoader = isShowing
            }.onReceive(self.viewModel.successToastPublisher.receive(on: RunLoop.main)) {
                showToast, message in
                self.successMessage = message
                withAnimation() {
                    self.showSuccessToast = showToast
                }
            }.onReceive(self.viewModel.errorToastPublisher.receive(on: RunLoop.main)) {
                showToast, message in
                self.errorMessage = message
                withAnimation() {
                    self.showErrorToast = showToast
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(AppState())
    }
}
