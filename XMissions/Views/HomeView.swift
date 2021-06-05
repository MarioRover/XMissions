//
//  HomeView.swift
//  XMissions
//
//  Created by Hossein Akbari on 3/15/1400 AP.
//

import SwiftUI

struct HomeView: View {
    @State var showBox = true
    
    
    var body: some View {
        ZStack {
            Color("navy-blue").edgesIgnoringSafeArea([.top,.bottom])
            
            VStack {
                Text("Home Page")
                    .foregroundColor(.white)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
