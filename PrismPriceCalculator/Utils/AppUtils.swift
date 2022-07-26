//
//  AppUtils.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/18/22.
//

import SwiftUI
import Foundation
import Combine

// MARK: - SuccessToast
struct SuccessToast: View {
    var message = ""
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text(self.message)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 8)
            .padding(.top, 8)
            .background(Color.green.blur(radius: 5))
            .cornerRadius(8)
            .shadow(color: .gray, radius: 10)
            .transition(.slide)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}

// MARK: - ErrorToast
struct ErrorToast: View {
    var message = ""
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text(self.message)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 8)
            .padding(.top, 8)
            .background(Color.red.blur(radius: 5))
            .cornerRadius(8)
            .shadow(color: .gray, radius: 10)
            .transition(.slide)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}

// MARK: - WarningToast
struct WarningToast: View {
    var message = ""
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text(self.message)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 8)
            .padding(.top, 8)
            .background(Color.yellow.blur(radius: 5))
            .cornerRadius(8)
            .shadow(color: .gray, radius: 10)
            .transition(.slide)
        }
        .padding(.leading, 32)
        .padding(.trailing, 32)
        .padding(.bottom, 20)
        .padding(.top, 20)
    }
}
