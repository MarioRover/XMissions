//
//  TabBar.swift
//  XMission
//
//  Created by Hossein Akbari on 1/28/1400 AP.
//

import SwiftUI

struct TabBar: View {
    
    @ObservedObject var model: ContentViewModel
    var tabItems: [Tab] = Tab.tabItems()

    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                ForEach(tabItems.indices) { index in
                    
                    GeometryReader { geometry in
                        VStack(spacing: 4) {
                            Image(uiImage: tabItems[index].image)
                                .resizable()
                                .frame(width: 28, height: 28, alignment: .center)
                                .foregroundColor(self.model.selectedIndex == index ? Color("background") : Color("light-gray"))
                                .rotationEffect(.degrees(
                                    self.model.selectedIndex == index ? -20 : 0
                                ))

                        }.onTapGesture {
                            withAnimation(.spring()) {
                                self.model.selectedIndex = index
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: geometry.size.width / 2, height: 44, alignment: .center)
                        .padding(.horizontal)
                        
                    }.frame(height: 44, alignment: .center)

                }
            }
            .padding([.top,.bottom], 25)
        }
        .background(Color.white)
        .cornerRadius(39)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(model: ContentViewModel()).previewLayout(.sizeThatFits)
    }
}
