//
//  SummaryView.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 11/6/22.
//

import SwiftUI

struct SummaryView: View {
//    var moduleGroup: ModuleGroup
//    @Binding var isExpanded: Bool
    @Binding var summaryList: [SummaryItem]
    @Binding var costSoftwareLicense: Int
    @Binding var costAdditionalUsers: Int
    @Binding var additionalUsers: Int
    @Binding var usersIncluded: Int
    @Binding var costImplementation: Int
    @Binding var costRequirementAnalysis: Int
    @Binding var costDeployment: Int
    @Binding var costConfiguration: Int
    @Binding var costOnsiteAdoptionSupport: Int
    @Binding var costTraining: Int
    @Binding var costProjectManagement: Int
    @Binding var costSoftwareCustomizationTotal: Int
    @Binding var costSoftwareCustomization: Int
    @Binding var costCustomizedReport: Int
    @Binding var costConsultancyServices: Int
    @Binding var costConsultancy: Int
    @Binding var costAnnualMaintenanceTotal: Int
    @Binding var costAnnualMaintenance: Int
    @Binding var submitButtonDisabled: Bool
    
    @ObservedObject var  viewModel: PriceCalculatorVM
    
    @State private var selectedTag: Int? = -1
    @State var shouldUpdate: Bool = true
    
    
    
    var body: some View {
        VStack(spacing: 5) {
            NavigationLink(destination: LoginView(), tag: 5, selection: self.$selectedTag) {
                EmptyView()
            }
            Group {
                HStack(spacing: 5) {
                    Text("Software License")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costSoftwareLicense > 0 ? "৳\(costSoftwareLicense)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 5)
                
                Divider()
                
                ForEach(summaryList, id: \.id) { summary in
                    HStack(spacing: 5) {
                        Text(summary.title.trimmingCharacters(in: .whitespacesAndNewlines))
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                        Spacer()
                        Text("৳\(summary.price)")
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                    }
                }
                
                HStack(spacing: 5) {
                    Text("\(usersIncluded) Users Included")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("[INCLUDED]")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                if additionalUsers > 0 {
                    HStack(spacing: 5) {
                        Text("\(additionalUsers) Additional User")
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                        Spacer()
                        Text(costAdditionalUsers > 0 ? "৳\(costAdditionalUsers)" : "-")
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                    }.padding(.top, 2)
                }
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Implementation")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costImplementation > 0 ? "৳\(costImplementation)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Requirement Analysis")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costRequirementAnalysis > 0 ? "৳\(costRequirementAnalysis)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Deployment")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costDeployment > 0 ? "৳\(costDeployment)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Configuration")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costConfiguration > 0 ? "৳\(costConfiguration)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Onsite Adoption Support")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costOnsiteAdoptionSupport > 0 ? "৳\(costOnsiteAdoptionSupport)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Training")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costTraining > 0 ? "৳\(costTraining)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Project Management")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costProjectManagement > 0 ? "৳\(costProjectManagement)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Software Customization")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costSoftwareCustomizationTotal > 0 ? "৳\(costSoftwareCustomizationTotal)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Software Customization")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costSoftwareCustomization > 0 ? "৳\(costSoftwareCustomization)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Customized Report")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costCustomizedReport > 0 ? "৳\(costCustomizedReport)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Consultancy Services")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costConsultancyServices > 0 ? "৳\(costConsultancyServices)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Consultancy")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costConsultancy > 0 ? "৳\(costConsultancy)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Annual Maintenance Cost")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costAnnualMaintenanceTotal > 0 ? "৳\(costAnnualMaintenanceTotal)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Annual Maintenance Cost")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costAnnualMaintenance > 0 ? "৳\(costAnnualMaintenance)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
            }
            
            Button(action: {
                if UserSessionManager.isLoggedIn {
                    submitSummary()
                } else {
                    selectedTag = 5
                }
                //bottomSheetPosition = .bottom
            }) {
                HStack {
                    Spacer()
                    Text("Submit").foregroundColor(.white).padding(.vertical, 5)
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(submitButtonDisabled ? Color("gray5") : Color("blue2"))).padding(.top, 10)
            }.disabled(submitButtonDisabled)
            Spacer()
        }
        .padding([.horizontal])
    }
    
    private func submitSummary() {
        let maintenance = SummaryService(
            header: "Annual Maintenance Cost", totalamount: costAnnualMaintenanceTotal,
            modules: [
                SummaryServiceModule(name: "Annual Maintenance Cost", details: nil,
                                     details_value: nil, details_multiplier: nil,
                                     totalamount: costAnnualMaintenance)
            ]
        )
        
        let consultancy = SummaryService(
            header: "Consultancy Services", totalamount: costConsultancyServices,
            modules: [
                SummaryServiceModule(name: "Consultancy", details: " man-days x ৳",
                                     details_value: 0, details_multiplier: 20000,
                                     totalamount: costConsultancy)
            ]
        )
        
        let customization = SummaryService(
            header: "Software Customization", totalamount: costSoftwareCustomizationTotal,
            modules: [
                SummaryServiceModule(name: "Software Customization", details: "man-days x ৳",
                                     details_value: costSoftwareCustomization / AppConstants.unitPriceSoftwareCustomization, details_multiplier: AppConstants.unitPriceSoftwareCustomization,
                                     totalamount: costSoftwareCustomization),
                SummaryServiceModule(name: "Customized Report", details: "man-days x ৳",
                                     details_value: costCustomizedReport / AppConstants.unitPriceCustomizedReports, details_multiplier: AppConstants.unitPriceCustomizedReports,
                                     totalamount: costCustomizedReport)
            ]
        )
        
        let implementation = SummaryService(
            header: "Implementation", totalamount: costImplementation,
            modules: [
                SummaryServiceModule(name: "Requirement Analysis", details: "man-days x ৳",
                                     details_value: 0, details_multiplier: 10000,
                                     totalamount: costRequirementAnalysis),
                SummaryServiceModule(name: "Deployment", details: "(onetime) x ৳",
                                     details_value: 1, details_multiplier: 10000,
                                     totalamount: costDeployment),
                SummaryServiceModule(name: "Configuration", details: "man-days x ৳",
                                     details_value: 0, details_multiplier: 10000,
                                     totalamount: costConfiguration),
                SummaryServiceModule(name: "Onsite Adoption Support", details: "man-days x ৳",
                                     details_value: 0, details_multiplier: 6000,
                                     totalamount: costOnsiteAdoptionSupport),
                SummaryServiceModule(name: "Training", details: "sessions x ৳",
                                     details_value: 0, details_multiplier: 6000,
                                     totalamount: costTraining),
                SummaryServiceModule(name: "Project Management", details: "man-days x ৳",
                                     details_value: 0, details_multiplier: 12000,
                                     totalamount: costProjectManagement)
            ]
        )
        
        var totatAmount = (consultancy.totalamount ?? 0) +
        (customization.totalamount ?? 0) + (implementation.totalamount ?? 0) // + (maintenance.totalamount ?? 0)
        
        var softwareLicenseModuleList: [SoftwareLicenseModule] = []
        
        for key in viewModel.softwareLicenseModuleMap.keys {
            if let softwareLicenseModule = viewModel.softwareLicenseModuleMap[key] {
                softwareLicenseModuleList.append(softwareLicenseModule)
                totatAmount += softwareLicenseModule.totalamount ?? 0
            }
        }
        
        let summarySoftwareLicense = SummarySoftwareLicense(additionalusers: additionalUsers, users: usersIncluded,
                                                            header: "Software License", totalamount: totatAmount,
                                                            modules: softwareLicenseModuleList)
        
        let summaryStoreBody = SummaryStoreModel(salesmanid: UserSessionManager.userAccount?.salesmanid,
                                                 customerid: UserSessionManager.userAccount?.id, details: false,
                                                 header: "Summery", productid: "prismerp",
                                                 totalamount: totatAmount, Software_License: summarySoftwareLicense,
                                                 Implementation: implementation, Customization: customization,
                                                 Consultancy: consultancy, Maintainance: maintenance, company: "RTC Hubs")
        viewModel.submitQuotation(quotationStoreBody: summaryStoreBody)
    }
}

