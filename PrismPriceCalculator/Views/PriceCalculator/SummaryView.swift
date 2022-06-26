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
    @State var summaryList: [SummaryItem] = []
    
    @Binding var costSoftwareLicense: Int
    @Binding var costAdditionalUsers: Int
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
    
    var body: some View {
        VStack(spacing: 5) {
            Group {
                HStack(spacing: 5) {
                    Text("Software License")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costSoftwareLicense > 0 ? "৳\(costSoftwareLicense)" : "-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top)
                
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
                    Text("0 Users Included")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("[INCLUDED]")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("5 Additional User")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text(costAdditionalUsers > 0 ? "৳\(costAdditionalUsers)" : "-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
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
              
            }) {
                HStack {
                    Spacer()
                    Text("Submit").foregroundColor(.white).padding(.vertical, 5)
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("blue2"))).padding(.top, 10)
            }
            Spacer()
        }.padding([.horizontal])
    }
}

