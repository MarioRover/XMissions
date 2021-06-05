//
//  NewsView.swift
//  XMissions
//
//  Created by Hossein Akbari on 3/15/1400 AP.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var newsVM: NewsViewModel
    
    init() {
        self.newsVM = NewsViewModel()
    }
    
    
    var body: some View {
        ZStack {
            Color("navy-blue").edgesIgnoringSafeArea([.top,.bottom])
            
            Text("News Page")
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
