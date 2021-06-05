//
//  Modifiers.swift
//  XMissions
//
//  Created by Hossein Akbari on 3/15/1400 AP.
//

import SwiftUI

struct Toast: ViewModifier {
    @Binding var isShowing: Bool
    let text: Text
    
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            ZStack {

                text
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .padding(10)
            }
            .background(Color("dark-gray"))
            .cornerRadius(8)
            .opacity(self.isShowing ? 1 : 0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isShowing = false
                    }
                }
            }
        }
    }
}

struct BlueBox: ViewModifier {
    func body(content: Content) -> some View {
        
        VStack(alignment: .leading) {
            content
                .padding([.top, .bottom], 15)
                .padding([.leading, .trailing], 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color("mid-blue"))
        .cornerRadius(5)
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        self.modifier(Toast(isShowing: isShowing, text: text))
    }
    
    func blueBox() -> some View {
        self.modifier(BlueBox())
    }
}
