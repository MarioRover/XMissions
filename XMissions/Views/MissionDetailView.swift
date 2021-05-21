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
                        
                        VStack(alignment: .leading) {
                            HStack {
                                MissionPath(url: self.missionDetailVM.mission?.links?.mission_patch_small ?? "")
                                
                                VStack(alignment: .leading) {
                                    Text(self.missionDetailVM.mission?.mission_name ?? "Unknown")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                    
                                    if let launchDate = self.missionDetailVM.mission?.launch_date_utc {
                                        HStack {
                                            Image(systemName: "calendar.badge.clock")
                                                .resizable()
                                                .frame(width: 15, height: 15, alignment: .center)
                                                .foregroundColor(Color("light-gray"))
                                            
                                            Text(Date.dateFormatter(time: launchDate))
                                                .foregroundColor(Color("light-gray"))
                                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                        }
                                    }
                                }.padding(.leading, 10)
                                
                                Spacer()
                            }
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 20)
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color("mid-blue"))
                        .cornerRadius(5)
                        .padding(.all, 15)
                        

                        Spacer()
                    }
                }
                    
                .navigationBarTitle(mission.mission_name ?? "Unkonwn")
                .navigationBarTitleDisplayMode(.inline)
                
            }.onAppear {
                self.missionDetailVM.getMissionDetail()
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

struct MissionPath: View {
    
    @ObservedObject var imageLoader: ImageLoaderViewModel
    
    private let frameSize = CGFloat(50)
    
    init(url: String) {
        self.imageLoader = ImageLoaderViewModel()
        if !url.isEmpty {
            self.imageLoader.downloadImage(url: url)
        }
    }
    
    
    
    var body: some View {
        
        HStack {
            if let image = self.imageLoader.downloadedImage {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .frame(width: frameSize, height: frameSize, alignment: .center)
                    .foregroundColor(.black)
            } else {
                VStack(alignment: .center) {
                    Image("rocket")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: .center)
                        .foregroundColor(Color("dark-gray"))
                }
                .frame(width: frameSize, height: frameSize, alignment: .center)
                .background(Color("light-gray"))
                .cornerRadius(50)
            }
        }
        
    }
}
