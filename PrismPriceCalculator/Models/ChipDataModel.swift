//
//  ChipDataModel.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/28/22.
//

import Foundation
import SwiftUI

struct ChipsDataModel: Identifiable {
    let id = UUID()
    let label: String
    @State var isSelected: Bool
}
