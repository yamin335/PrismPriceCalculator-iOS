//
//  PriceCalculatorView.swift
//  PrismPriceCalculator
//
//  Created by Mamun Ar Rashid on 31/5/22.
//

import SwiftUI

struct ModuleRowView: View {
    var module: ServiceModule

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(module.name)
                .foregroundColor(.primary)
                .font(.headline)
            HStack(spacing: 3) {
                Label(module.code, systemImage: "phone")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}

struct ModuleHeaderView: View {
    var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text(moduleGroup.name)
                    .foregroundColor(Color("textColor2"))
                    .font(.headline)
                Text("11 modules")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .medium))
                    .frame(height: 20)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("blue1")))
                Text(isExpanded ? "Click to hide Modules" : "Click to show Modules")
                    .foregroundColor(Color("blue1"))
                    .font(.system(size: 10))
                Spacer()
            }
            Spacer()
            VStack(spacing: 6) {
                HStack(spacing: 5) {
                    Image("ic_select_all")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                    Image("ic_add_circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                    Image("is_toggle_selection")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                    Image("ic_clear_circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                }
                Text("No module selected")
                    .foregroundColor(.black)
                    .font(.system(size: 11, weight: .medium))
                    .frame(height: 24)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 12, style: .circular).fill(Color("yellow1")))
                Spacer()
            }
        }
    }
}

struct ModuleDetailView: View {
    var moduleGroup: ModuleGroup
    @Binding var isExpanded: Bool

    var body: some View {
        if isExpanded {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(moduleGroup.modules, id: \.id) { module in
                        ModuleRowView(module: module)
                }
            }
        }
    }
}

struct ModuleItemView: View {
    @State var isExpanded: Bool = false
    var moduleGroup: ModuleGroup
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ModuleHeaderView(moduleGroup: moduleGroup, isExpanded: $isExpanded)
                .onTapGesture {
                    withAnimation {
                        isExpanded = !isExpanded
                    }
                }
            ModuleDetailView(moduleGroup: moduleGroup, isExpanded: self.$isExpanded)
        }
    }
}

struct PriceCalculatorView: View {
    let backgroundColors: [Color] = [Color(red: 0.2, green: 0.85, blue: 0.7), Color(red: 0.13, green: 0.55, blue: 0.45)]
    let readMoreColors: [Color] = [Color(red: 0.70, green: 0.22, blue: 0.22), Color(red: 1, green: 0.32, blue: 0.32)]
    let bookmarkColors: [Color] = [Color(red: 0.28, green: 0.28, blue: 0.53), Color(red: 0.44, green: 0.44, blue: 0.83)]
    
    @State var bottomSheetPosition: BottomSheetPosition = .bottom
    
    @State private var showSideMenu = false
    
    @State var baseModuleList: [BaseServiceModule] = []
    @State var moduleGroupList: [ModuleGroup] = []
    
    @ObservedObject var viewModel = PriceCalculatorVM()
    
    var body: some View {
        GeometryReader { geometry in
           NavigationView {
               ScrollView {
                   ForEach(moduleGroupList) { moduleGroup in
                       ModuleItemView(moduleGroup: moduleGroup)
                           .padding(.leading, 10)
                           .padding(.trailing, 10)
                           .padding(.top, 10)
                           .padding(.bottom, 10)
                           .overlay (
                                RoundedRectangle(cornerRadius: 5, style: .circular).stroke(Color("gray4"), lineWidth: 0.8)
                           )
                   }
               }
               .padding(.leading, 10)
               .padding(.trailing, 10)
               .navigationTitle("Prism Price Calculator")
               .navigationBarItems(trailing: (
                   Button(action: {
                       withAnimation {
                           self.showSideMenu.toggle()
                       }
                   }) {
                       Image(systemName: "line.horizontal.3")
                           .imageScale(.large)
                   }
               )).onReceive(self.viewModel.baseModuleList.receive(on: RunLoop.main)) { baseModuleList in
                   self.baseModuleList = baseModuleList
                   if self.baseModuleList.count > 0 {
                       self.moduleGroupList = self.baseModuleList[0].moduleGroups
                   }
               }.onAppear {
                   viewModel.loadAllModuleData()
               }
           }.sideMenu(isShowing: $showSideMenu) {
               VStack(alignment: .leading) {
                 Button(action: {
                   withAnimation {
                     self.showSideMenu = false
                   }
                 }) {
                   HStack {
                     Image(systemName: "xmark")
                       .foregroundColor(.white)
                     Text("close menu")
                   
                       .font(.system(size: 14))
                       .padding(.leading, 15.0)
                   }
                 }.padding(.top, 20)
                   Divider()
                       .frame(height: 20)
                   List {
                       ForEach(baseModuleList) { baseModule in
                           Button(action: {
                             withAnimation {
                               self.showSideMenu = false
                                 self.setModule(baseModule: baseModule)
                             }
                           }) {
                               Text(baseModule.code)
                           }
                       }
                   }
                  Spacer()
                }.padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
           }.bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, options: [ .allowContentDrag, .relativePositionValue], headerContent: {
               //The name of the book as the heading and the author as the subtitle with a divider.
               VStack(alignment: .leading) {
                   Text("Summary")
                       .font(.system(size: 20)).bold()
                       .foregroundColor(Color("textColor1"))
                   
                   HStack(spacing: 5) {
                       Text("Total")
                           .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                       Spacer()
                       Text("৳1,50,000")
                           .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                   }.padding(.top, 2)
                   
                   Divider()
                   
               }
           }) {
               //A short introduction to the book, with a "Read More" button and a "Bookmark" button.
               VStack(spacing: 5) {
                   Group {
                       HStack(spacing: 5) {
                           Text("Software License")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("৳1,90,000")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                       }.padding(.top)
                       
                       Divider()
                       
                       HStack(spacing: 5) {
                           Text("0 Users Included")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("[INCLUDED]")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }
                       
                       HStack(spacing: 5) {
                           Text("5 Additional User")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("৳1,50,000")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }.padding(.top, 2)
                   }
                   
                   Group {
                       HStack(spacing: 5) {
                           Text("Implementation")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("৳10,000")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                       }.padding(.top, 8)
                       
                       Divider()
                       
                       HStack(spacing: 5) {
                           Text("Requirement Analysis")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }
                       
                       HStack(spacing: 5) {
                           Text("Deployment")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("৳10,000")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }.padding(.top, 2)
                       
                       HStack(spacing: 5) {
                           Text("Configuration")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }.padding(.top, 2)
                       
                       HStack(spacing: 5) {
                           Text("Onsite Adoption Support")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }.padding(.top, 2)
                       
                       HStack(spacing: 5) {
                           Text("Training")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }.padding(.top, 2)
                       
                       HStack(spacing: 5) {
                           Text("Project Management")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }.padding(.top, 2)
                   }
                   
                   Group {
                       HStack(spacing: 5) {
                           Text("Software Customization")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                       }.padding(.top, 8)
                       
                       Divider()
                       
                       HStack(spacing: 5) {
                           Text("Software Customization")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }
                       
                       HStack(spacing: 5) {
                           Text("Customized Report")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }.padding(.top, 2)
                   }
                   
                   Group {
                       HStack(spacing: 5) {
                           Text("Consultancy Services")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                       }.padding(.top, 8)
                       
                       Divider()
                       
                       HStack(spacing: 5) {
                           Text("Consultancy")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("-")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }
                       
                       HStack(spacing: 5) {
                           Text("Annual Maintenance Cost")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("৳30,000")
                               .font(.system(size: 15, weight: .medium)).foregroundColor(Color("green1"))
                       }.padding(.top, 8)
                       
                       Divider()
                       
                       HStack(spacing: 5) {
                           Text("Annual Maintenance Cost")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("textColor2"))
                           Spacer()
                           Text("৳30,000")
                               .font(.system(size: 13, weight: .regular)).foregroundColor(Color("green1"))
                       }
                   }
                   
                   Button(action: {
                     
                   }) {
                       HStack {
                           Spacer()
                           Text("Add To Cart").foregroundColor(.white).padding(.vertical, 5)
                           Spacer()
                       }
                       .background(RoundedRectangle(cornerRadius: 10, style: .circular).fill(Color("blue2"))).padding(.top, 10)
                   }
                   Spacer()
               }.padding([.horizontal])
           }
       }
    }
    
    func setModule(baseModule: BaseServiceModule) {
        self.moduleGroupList = baseModule.moduleGroups
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PriceCalculatorView()
    }
}
