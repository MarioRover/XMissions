//
//  ViewTools.swift
//  XMissions
//
//  Created by Hossein Akbari on 3/7/1400 AP.
//

import SwiftUI

struct ViewTools {
    struct LabelledDivider: View {

        let label: String
        let horizontalPadding: CGFloat
        let color: Color

        init(label: String, horizontalPadding: CGFloat = 0, color: Color = Color("dark-gray")) {
            self.label = label
            self.horizontalPadding = horizontalPadding
            self.color = color
        }

        var body: some View {
            HStack {
                line
                Text(label)
                    .foregroundColor(color)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                line
            }
        }

        var line: some View {
            VStack {
                Divider()
                    .background(color)
            }
            .padding(horizontalPadding)
        }
    }
    
    
    struct HeaderSection: View {
        
        let title: String
        let size: CGFloat
        let paddingBottom: CGFloat
        let paddingLeading: CGFloat
        let color: Color
        
        init(title: String, size: CGFloat = 18, paddingBottom: CGFloat = 14, paddingLeading: CGFloat = 0, color: Color = .white) {
            self.title = title
            self.size = size
            self.paddingBottom = paddingBottom
            self.paddingLeading = paddingLeading
            self.color = color
        }
        
        var body: some View {
            Text(self.title)
                .foregroundColor(self.color)
                .font(.system(size: self.size, weight: .bold, design: .rounded))
                .padding([.bottom], self.paddingBottom)
                .padding(.leading, self.paddingLeading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


