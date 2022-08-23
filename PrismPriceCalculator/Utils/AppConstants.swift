//
//  AppConstants.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/18/22.
//

import Foundation
import SwiftUI

struct AppConstants {
    // MARK: - Local Storage Keys
    static let keyIsLoggedIn = "is_logged_in"
    static let keyLoginToken = "login_token"
    static let keyUserAccount = "user_account"
    static let percentRequirementAnalysis = 10
    static let percentDeployment = 5
    static let percentConfiguration = 5
    static let percentOnSiteAdoption = 5
    static let percentTraining = 3
    static let percentProjectManagement = 10
    static let percentConsultancy = 10
    static let percentMaintenance = 20
    static let costAdditionalUsers = 150000
    static let unitPriceSoftwareCustomization = 16000
    static let unitPriceCustomizedReports = 16000
    static let perUserCost = 50000
    static let additionalUsers = 5
    
    static let labelCustom = "Custom"
    
    // MARK: - BottomSheetConstants
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 5
    static let indicatorWidth: CGFloat = 50
    static let snapRatio: CGFloat = 0.03
    static let minHeightRatio: CGFloat = 0.2
}
