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
                        
                        VStack(spacing: 20) {
                            InformationView(missionDetailVM: self.missionDetailVM)
                            
                            if (self.missionDetailVM.mission != nil) {
                                RocketInfo(missionDetailVM: self.missionDetailVM)
                                
                                SiteInfo(missionDetailVM: self.missionDetailVM)
                            }
                            
                        }.padding(.all, 15)
                        
                        Spacer()
                    }
                }
                    
                .navigationBarTitle(mission.mission_name ?? "Unkonwn")
                .navigationBarTitleDisplayMode(.inline)
                
            }.onAppear {
                self.missionDetailVM.getMissionDetail()
            }
            .toast(isShowing: self.$missionDetailVM.isConnectionIssue, text: Text("Couldn't refresh"))
        

    }
}

struct MissionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MissionDetailView(mission: LaunchModel(id: "", launch_date_utc: "", links: LinkModel(article_link: "", flickr_images: [], mission_patch: "", mission_patch_small: "", reddit_campaign: "", video_link: "", wikipedia: ""), mission_name: ""))
    }
}

// MARK: - Image Slider
struct ImageSlider: View {
    private let images = AssetsImages.missions()
    @State var currentIndex = Int.random(in: 0...5)
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: self.$currentIndex) {
            ForEach(1..<7) { num in
                Image("mission-\(num)")
                    .resizable()
                    .scaledToFit()
                    .tag(num)

            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(width: UIScreen.main.bounds.width, height: 260)
        .onReceive(timer, perform: { _ in
            withAnimation {
                currentIndex = currentIndex < 6 ? currentIndex + 1 : 0
            }
        })
    }
}

// MARK: - Information View
struct InformationView: View {
    @ObservedObject var missionDetailVM: MissionDetailViewModel
    
    init(missionDetailVM: MissionDetailViewModel) {
        self.missionDetailVM = missionDetailVM
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                MissionPath(url: self.missionDetailVM.mission?.links?.mission_patch_small ?? "")
                
                VStack(alignment: .leading) {
                    Text(self.missionDetailVM.mission?.mission_name ?? "Unknown")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    
                    if self.missionDetailVM.loading {
                        Text("#################")
                            .foregroundColor(Color("light-gray"))
                    }
                    
                    
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
                }
                .padding(.leading, 10)
                
                Spacer()
            }
            
            ViewTools.LabelledDivider(label: "Details")
        
            VStack(alignment: .leading) {
                Text(self.missionDetailVM.mission?.details ?? Tool.loremIpsum)
                    .foregroundColor(Color("light-gray"))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }
        .blueBox()
        .redacted(reason: self.missionDetailVM.loading || (self.missionDetailVM.mission == nil) ? .placeholder : [])
    }
}

// MARK: - Mission Path
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

// MARK: - Rocket Info
struct RocketInfo: View {
    @ObservedObject var missionDetailVM: MissionDetailViewModel
    let rocket: RocketModel?
    
    init(missionDetailVM: MissionDetailViewModel) {
        self.missionDetailVM = missionDetailVM
        self.rocket = missionDetailVM.mission?.rocket
    }
    
    var body: some View {
        VStack {
            ViewTools.HeaderSection(title: "Rocket", paddingBottom: 0)
            
            VStack(alignment: .leading, spacing: 10) {
                
                RowData(label: "Name", value: rocket?.rocket_name ?? "")
                RowData(label: "Type", value: rocket?.rocket_type ?? "")
                RowData(rowType: .bool, label: "Launch success", value: "", bool: self.missionDetailVM.mission?.launch_success ?? false)
                
                
            }
            .blueBox()
        }
    }
}

// MARK: - Site Info
struct SiteInfo: View {
    @ObservedObject var missionDetailVM: MissionDetailViewModel
    let site: LaunchSiteModel?
    
    init(missionDetailVM: MissionDetailViewModel) {
        self.missionDetailVM = missionDetailVM
        self.site = missionDetailVM.mission?.launch_site
    }
    
    var body: some View {
        VStack {
            ViewTools.HeaderSection(title: "Launch Site", paddingBottom: 0)
            
            VStack(alignment: .leading, spacing: 10) {
                RowData(label: "Name", value: self.site?.site_name ?? "")
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Long name")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    
                    Text(self.site?.site_name_long ?? "")
                        .foregroundColor(Color("light-gray"))
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                }
            }
            .blueBox()
        }
    }
}

// MARK: - Row Data
struct RowData: View {
    let rowType: RowType
    let label: String
    let value: String
    let bool: Bool
    
    enum RowType {
        case bool
        case string
    }
    
    init(rowType: RowType = .string , label: String, value: String, bool: Bool = false) {
        self.rowType = rowType
        self.label = label
        self.value = value
        self.bool = bool
    }
    
    
    
    var body: some View {
        HStack {
            Text(self.label)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
            
            Spacer()
            
            if rowType == .string {
                Text(self.value.isEmpty ? "Unknown" : self.value)
                    .foregroundColor(Color("light-gray"))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
            } else if rowType == .bool {
                if bool {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                        .frame(width: 20, height: 20, alignment: .center)
                } else {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                        .frame(width: 20, height: 20, alignment: .center)
                }
                
            }
        }
    }
}


