//
//  TextStyle.swift
//  itsgood
//
//  Created by Mark Jeschke on 2/24/22.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content   
            .font(Font.custom("Hiragino Mincho ProN", size: 30))
            .lineSpacing(5)
            .foregroundColor(Color.blue )
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Hiragino Mincho ProN", size: 15))
            .lineSpacing(4)
            .foregroundColor(.secondary)
    }
}


extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
