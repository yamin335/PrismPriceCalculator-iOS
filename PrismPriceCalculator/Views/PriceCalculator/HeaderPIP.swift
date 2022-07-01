//
//  HeaderPIP.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct HeaderPIP: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    @State private var softwareCustomization: Double = 0
    @State private var newReports: Double = 0
    @State private var adoptionSupport: Double = 0
    @State private var projectManagement: Double = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Software Customization")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
            
            HStack {
                Text("STD(0)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.leading, 10)
                
                Slider(value: $softwareCustomization, in: 0...50, step: 1)
                
                Text("MAX(50)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.trailing, 10)
            }
            
            Text("New Reports")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)
            
            HStack {
                Text("STD(0)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.leading, 10)
                
                Slider(value: $newReports, in: 0...50, step: 1)
                
                Text("MAX(50)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.trailing, 10)
            }
            
            Text("Onsite Adoption Support")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)
            
            HStack {
                Text("STD(0)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.leading, 10)
                
                Slider(value: $adoptionSupport, in: 0...50, step: 1)
                
                Text("MAX(50)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.trailing, 10)
            }
            
            Text("Project management")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)
            
            HStack {
                Text("STD(0)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.leading, 10)
                
                Slider(value: $projectManagement, in: 0...50, step: 1)
                
                Text("MAX(50)")
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor2"))
                    .padding(.trailing, 10)
            }
            Spacer()
        }
    }
}

struct HeaderPIP_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPIP(viewModel: PriceCalculatorVM())
    }
}
