//
//  MyQuotationView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 9/14/22.
//

import SwiftUI

struct MyQuotationView: View {
    @EnvironmentObject var appGlobalState: AppState
    @StateObject var viewModel = MyQuotationVM()
    @Environment(\.presentationMode) var presentationMode
    @State var myQuotationList: [MyQuotation] = []
    @State private var selectedTag: Int? = -1
    @State var showSuccessToast = false
    @State var successMessage: String = ""
    @State var showErrorToast = false
    @State var errorMessage: String = ""
    
    @State private var showLoader = false
    
    @State private var productId = ""
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(myQuotationList, id: \.quotationid) { myQuotation in
                        MyQuotationListItem(quotation: myQuotation)
                        .background(.white)
                        .clipped()
                        .cornerRadius(5)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            productId = myQuotation.productid ?? ""
                            selectedTag = 1
                        }
                    }
                    
                    NavigationLink(destination: PriceCalculatorView( productId: productId), tag: 1, selection: self.$selectedTag) {
                        EmptyView()
                    }.isDetailLink(false)
                    
                    NavigationLink(destination: LoginView(), tag: 2, selection: self.$selectedTag) {
                        EmptyView()
                    }.isDetailLink(false)
                    
                    Spacer()
                }.padding(.vertical, 16).onReceive(self.viewModel.myQuotationListPublisher.receive(on: RunLoop.main)) { myQuotations in
                    self.myQuotationList = myQuotations
                }
            }
            .background(Color("Theme Background"))
            .navigationTitle("My Quotations")
            
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
        .onAppear {
            self.viewModel.loadMyQuotationList(email: UserSessionManager.userAccount?.email ?? "", page: "1")
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
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if UserSessionManager.isLoggedIn {
                        UserSessionManager.logout()
                        appGlobalState.isLoggedIn = false
                        selectedTag = -1
                        withAnimation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
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
    }
}

struct MyQuotationView_Previews: PreviewProvider {
    static var previews: some View {
        MyQuotationView()
            .previewInterfaceOrientation(.portrait)
            .previewLayout(.device)
            .previewDevice("iPhone 13")
    }
}
