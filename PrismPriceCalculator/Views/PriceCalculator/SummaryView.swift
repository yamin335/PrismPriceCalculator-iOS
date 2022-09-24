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
                    Text(viewModel.costSoftwareLicense > 0 ? "৳\(viewModel.costSoftwareLicense)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 5)
                
                Divider()
                
                ForEach(viewModel.summaryList, id: \.id) { summary in
                    HStack(spacing: 5) {
                        Text(summary.title.trimmingCharacters(in: .whitespacesAndNewlines))
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                        Spacer()
                        Text("৳\(summary.price)")
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                    }
                }
                
                HStack(spacing: 5) {
                    Text("\(viewModel.usersIncluded) Users Included")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("[INCLUDED]")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                if viewModel.additionalUsers > 0 {
                    HStack(spacing: 5) {
                        Text("\(viewModel.additionalUsers) Additional User")
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                        Spacer()
                        Text(viewModel.costAdditionalUsers > 0 ? "৳\(viewModel.costAdditionalUsers)" : "-")
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                    }.padding(.top, 2)
                }
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Implementation")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costImplementation > 0 ? "৳\(viewModel.costImplementation)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Requirement Analysis")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costRequirementAnalysis > 0 ? "৳\(viewModel.costRequirementAnalysis)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Deployment")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costDeployment > 0 ? "৳\(viewModel.costDeployment)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Configuration")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costConfiguration > 0 ? "৳\(viewModel.costConfiguration)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Onsite Adoption Support")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costOnsiteAdoptionSupport > 0 ? "৳\(viewModel.costOnsiteAdoptionSupport)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Training")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costTraining > 0 ? "৳\(viewModel.costTraining)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Project Management")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costProjectManagement > 0 ? "৳\(viewModel.costProjectManagement)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Software Customization")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costSoftwareCustomizationTotal > 0 ? "৳\(viewModel.costSoftwareCustomizationTotal)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Software Customization")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costSoftwareCustomization > 0 ? "৳\(viewModel.costSoftwareCustomization)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Customized Report")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costCustomizedReport > 0 ? "৳\(viewModel.costCustomizedReport)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Consultancy Services")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costConsultancyServices > 0 ? "৳\(viewModel.costConsultancyServices)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Consultancy")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costConsultancy > 0 ? "৳\(viewModel.costConsultancy)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Annual Maintenance Cost")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costAnnualMaintenanceTotal > 0 ? "৳\(viewModel.costAnnualMaintenanceTotal)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Annual Maintenance Cost")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(viewModel.costAnnualMaintenance > 0 ? "৳\(viewModel.costAnnualMaintenance)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
            }
            
            Button(action: {
                if UserSessionManager.isLoggedIn {
                    if !viewModel.moduleChangeMapOld.isEmpty
                        && !viewModel.moduleChangeMapNew.isEmpty
                        && viewModel.moduleChangeMapOld.count != viewModel.moduleChangeMapNew.count {
                        viewModel.submitOrUpdateSummary()
                    } else {
                        var hasChanged = false
                        for key in viewModel.moduleChangeMapOld.keys {
                            if viewModel.moduleChangeMapOld[key] != viewModel.moduleChangeMapNew[key] {
                                hasChanged = true
                                break
                            }
                        }
                        if hasChanged {
                            viewModel.submitOrUpdateSummary()
                        } else {
                            viewModel.errorToastPublisher.send((true, "No changes found!"))
                        }
                    }
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
}

