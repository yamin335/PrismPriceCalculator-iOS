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
    
    var body: some View {
        VStack(spacing: 5) {
            Group {
                HStack(spacing: 5) {
                    Text("Software License")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("৳1,90,000")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top)
                
                Divider()
                
                ForEach(summaryList, id: \.id) { summary in
                    HStack(spacing: 5) {
                        Text(summary.title)
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
                    Text("৳1,50,000")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Implementation")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("৳10,000")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Requirement Analysis")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Deployment")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("৳10,000")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Configuration")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Onsite Adoption Support")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Training")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
                
                HStack(spacing: 5) {
                    Text("Project Management")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Software Customization")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Software Customization")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Customized Report")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }.padding(.top, 2)
            }
            
            Group {
                HStack(spacing: 5) {
                    Text("Consultancy Services")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Consultancy")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("-")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                }
                
                HStack(spacing: 5) {
                    Text("Annual Maintenance Cost")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("৳30,000")
                        .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                }.padding(.top, 8)
                
                Divider()
                
                HStack(spacing: 5) {
                    Text("Annual Maintenance Cost")
                        .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                    Spacer()
                    Text("৳30,000")
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

