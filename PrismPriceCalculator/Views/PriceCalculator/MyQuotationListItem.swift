//
//  MyQuotationListItem.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 9/14/22.
//

import SwiftUI

struct MyQuotationListItem: View {
    var quotation: MyQuotation
    @State var dateTime: String = "Date: N/A\nTime: N/A"
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom, spacing: 5) {
                Text("ID:")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("textColor1"))

                Text("\((quotation.quotationid == nil || quotation.quotationid?.isEmpty == true ? "N/A" : quotation.quotationid) ?? "N/A")")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("textColor1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(dateTime)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Color("textColor4"))
                    .multilineTextAlignment(.trailing)
            }
            HStack(alignment: .center, spacing: 5) {
                VStack(spacing: 2) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Product ID:")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                        
                        Text("\((quotation.productid == nil || quotation.productid?.isEmpty == true ? "N/A" : quotation.productid) ?? "N/A")")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack(alignment: .center, spacing: 5) {
                        Text("Customer:")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                        
                        Text("\((quotation.customername == nil || quotation.customername?.isEmpty == true ? "N/A" : quotation.customername) ?? "N/A")")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack(alignment: .center, spacing: 5) {
                        Text("Company:")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                        
                        Text("\((quotation.company == nil || quotation.company?.isEmpty == true ? "N/A" : quotation.company) ?? "N/A")")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack(alignment: .center, spacing: 5) {
                        Text("Status:")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                        
                        Text("\((quotation.status == nil || quotation.status?.isEmpty == true ? "N/A" : quotation.status) ?? "N/A")")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color("textColor4"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity)
                Image(systemName: "chevron.right").foregroundColor(Color("textColor3"))
            }
            
            VStack(spacing: 2) {
                HStack(alignment: .center, spacing: 5) {
                    Text("Discount:")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color("textColor2"))
                    
                    Text("\((quotation.discount == nil ? 0 : quotation.discount) ?? 0) BDT")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color("textColor2"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack(alignment: .center, spacing: 5) {
                    Text("Total Cost:")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color("textColor2"))
                    
                    Text("\((quotation.totalamount == nil ? 0 : quotation.totalamount) ?? 0) BDT")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color("textColor2"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(12)
        .onAppear {
            var date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            date = dateFormatter.date(from: quotation.date ?? "") ?? Date()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let dateString = dateFormatter.string(from: date)
            dateFormatter.dateFormat = "hh:mm a"
            let timeString = dateFormatter.string(from: date)
            dateTime = "Date: \(dateString)\nTime: \(timeString)"
        }
    }
}

//struct MyQuotationListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MyQuotationListItem()
//    }
//}
