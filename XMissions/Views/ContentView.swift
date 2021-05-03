//
//  ContentView.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentVM: ContentViewModel
    
    init() {
        self.contentVM = ContentViewModel()
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.white),
            .font: UIFont.systemFont(ofSize: 26, weight: .bold)
        ]
//        UINavigationBar.appearance().barTintColor = UIColor(Color("mid-blue"))
//        UINavigationBar.appearance().tintColor = UIColor(Color.white)
    }
    
    var body: some View {
        ZStack {
            Color("navy-blue").edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    switch self.contentVM.selectedIndex {
                    case 0:
                        Text("Home")
                    case 1:
                        Text("Vehicles")
                    case 2:
                        Text("Missions")
                    case 3:
                        Text("News")
                    case 4:
                        CompanyView()
                    default:
                        Text("Home")
                    }
                }.foregroundColor(.blue)
                
                Spacer()
                
                TabBar(model: self.contentVM)
                
            }.ignoresSafeArea(.all, edges: [.bottom, .top])
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
