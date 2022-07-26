//
//  SpinLoaderView.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 7/18/22.
//

import Foundation
import SwiftUI

struct SpinLoaderView: View {
    
    @State var spinCircle = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0.3, to: 1)
                .stroke(Color.green, lineWidth:4)
                .frame(width:40, height: 40)
                .padding(.all, 8)
                .rotationEffect(.degrees(spinCircle ? 0 : -360), anchor: .center)
                .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false), value: spinCircle)
                .onAppear {
                    self.spinCircle = true
                }
            Text("Please wait...").foregroundColor(.white)
        }
        .background(AnyView(EffectView(effect: UIBlurEffect(style: .systemMaterialDark))).frame(width:150, height: 125).cornerRadius(8).shadow(color: Color("textColor3"), radius: 16))
        //.background(Rectangle().frame(width:150, height: 125).background(AnyView(EffectView(effect: UIBlurEffect(style: .prominent)))).cornerRadius(8).shadow(color: .black, radius: 16))
    }
}

struct SpinLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        SpinLoaderView()
    }
}
