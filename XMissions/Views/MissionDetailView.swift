//
//  MissionDetailView.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/23/1400 AP.
//

import SwiftUI

struct MissionDetailView: View {
    
    let mission: LaunchModel
    @ObservedObject var missionDetailVM: MissionDetailViewModel

    
    init(mission: LaunchModel) {
        self.mission = mission
        self.missionDetailVM = MissionDetailViewModel(id: mission.id ?? "")
    }
    
    var body: some View {
        
            ZStack {
                Color("navy-blue").edgesIgnoringSafeArea([.top,.bottom])
                
                ScrollView {
                    VStack {

                        ImageSlider()
                        
                        Spacer()

                        Text("Hello").foregroundColor(.white)

                        Spacer()
                    }
                }
                    
                .navigationBarTitle(mission.mission_name ?? "Unkonwn")
                .navigationBarTitleDisplayMode(.inline)
            }
        

    }
}

struct MissionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDetailView(mission: LaunchModel(id: "", launch_date_utc: "", links: LinkModel(article_link: "", flickr_images: [], mission_patch: "", mission_patch_small: "", reddit_campaign: "", video_link: "", wikipedia: ""), mission_name: ""))
    }
}

struct ImageSlider: View {
    private let images = AssetsImages.missions()
    
    var body: some View {
        TabView {
            ForEach(images) { item in
                item.image
                    .resizable()
                    .scaledToFit()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(width: UIScreen.main.bounds.width, height: 260)
    }
}
