//
//  AppleDemo.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 5/6/22.
//

import SwiftUI


//The custom BottomSheetPosition enum with absolute values.
enum BookBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 325, bottom = 125, hidden = 0
}

struct BookDetailView: View {
    
    @State var bottomSheetPosition: BookBottomSheetPosition = .middle
    
    let backgroundColors: [Color] = [Color(red: 0.2, green: 0.85, blue: 0.7), Color(red: 0.13, green: 0.55, blue: 0.45)]
    let readMoreColors: [Color] = [Color(red: 0.70, green: 0.22, blue: 0.22), Color(red: 1, green: 0.32, blue: 0.32)]
    let bookmarkColors: [Color] = [Color(red: 0.28, green: 0.28, blue: 0.53), Color(red: 0.44, green: 0.44, blue: 0.83)]
    
    var body: some View {
        //A green gradient as a background that ignores the safe area.
        LinearGradient(gradient: Gradient(colors: self.backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, options: [.noDragIndicator, .allowContentDrag, .showCloseButton(), .swipeToDismiss, .tapToDismiss, .absolutePositionValue], headerContent: {
                //The name of the book as the heading and the author as the subtitle with a divider.
                VStack(alignment: .leading) {
                    Text("Wuthering Heights")
                        .font(.title).bold()
                    
                    Text("by Emily Brontë")
                        .font(.subheadline).foregroundColor(.secondary)
                    
                    Divider()
                        .padding(.trailing, -30)
                }
            }) {
                //A short introduction to the book, with a "Read More" button and a "Bookmark" button.
                VStack(spacing: 0) {
                    Text("This tumultuous tale of life in a bleak farmhouse on the Yorkshire moors is a popular set text for GCSE and A-level English study, but away from the demands of the classroom it’s easier to enjoy its drama and intensity. Populated largely by characters whose inability to control their own emotions...")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack {
                        Button(action: {}, label: {
                            Text("Read More")
                                .padding(.horizontal)
                        })
                        .buttonStyle(BookButton(colors: self.readMoreColors)).clipShape(Capsule())
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "bookmark")
                        })
                        .buttonStyle(BookButton(colors: self.bookmarkColors)).clipShape(Circle())
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal, .top])
            }
    }
}

//The gradient ButtonStyle.
struct BookButton: ButtonStyle {
    
    let colors: [Color]
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
