//
//  HeaderHCM.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/1/22.
//

import SwiftUI

struct HeaderHCM: View {
    @ObservedObject var viewModel: PriceCalculatorVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Employees")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)

//            ChipGroup(chips: viewModel.employees, selectedItemIndex: 0)
//                .padding(.leading, 10)

            Text("Attendance Devices")
                .foregroundColor(Color("textColor3"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

//            ChipGroup(chips: viewModel.attendanceDevices, selectedItemIndex: 0)
//                .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct HeaderHCM_Previews: PreviewProvider {
    static var previews: some View {
        HeaderHCM(viewModel: PriceCalculatorVM())
    }
}
