//
//  DashboardView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/13/22.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel = DashboardVM()
    @State var businessServiceList: [BusinessService] = []
    @State private var isShowingDetailView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                ForEach(businessServiceList, id: \.id) { businessServiceItem in
                    DashboardListItem(businessServiceItem: businessServiceItem)
                }
                
                Spacer()
            }
            .padding(.vertical, 16)
            .navigationTitle("Prism Price Calculator")
            .onReceive(self.viewModel.businessServiceListPublisher.receive(on: RunLoop.main)) { businessServiceList in
                self.businessServiceList = businessServiceList
            }
            .onAppear {
                self.viewModel.getBusinessServiceList()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: LoginView()) {
                        Text("LOGIN")
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
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
