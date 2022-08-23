//
//  DraggableBottomSheet.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 8/21/22.
//

import Foundation
import SwiftUI

struct DraggableBottomSheet<Header: View, Content: View>: View {
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let header: Header
    let content: Content
    
    var animation: Animation = Animation.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 1)
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: AppConstants.radius)
            .fill(Color("shadowColor"))
            .frame(
                width: AppConstants.indicatorWidth,
                height: AppConstants.indicatorHeight
        )
    }
    
    @GestureState private var translation: CGFloat = 0

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder headerView: () -> Header, @ViewBuilder contentView: () -> Content) {
        self.minHeight = maxHeight * AppConstants.minHeightRatio
        self.maxHeight = maxHeight
        self.header = headerView()
        self.content = contentView()
        self._isOpen = isOpen
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    self.indicator.onTapGesture {
                        withAnimation {
                            isOpen.toggle()
                        }
                    }.padding()
                    self.header
                }
                .background(.white)
                .onTapGesture(count: 2, perform: {
                    withAnimation {
                        isOpen.toggle()
                    }
                })
                
                self.content
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(.white)
            .cornerRadius(AppConstants.radius)
            .frame(height: geometry.size.height + 20, alignment: .bottom)
            .shadow(color: Color("shadowColor"), radius: 8, x: 1, y: 2)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(animation, value: isOpen)
            .animation(animation, value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    withAnimation {
                        let snapDistance = self.maxHeight * AppConstants.snapRatio
                        guard abs(value.translation.height) > snapDistance else {
                            return
                        }
                        self.isOpen = value.translation.height < 0
                    }
                }
            )
        }
    }
}
