//
//  MissionsView.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/15/1400 AP.
//

import SwiftUI

struct MissionsView: View {
    
    let launchesPast: [LaunchModel]
    let loading: Bool
    
    init(launchesPast: [LaunchModel], loading: Bool) {
        self.launchesPast = launchesPast
        self.loading = loading
        UITableView.appearance().backgroundColor = .clear
    }

    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("navy-blue").edgesIgnoringSafeArea(.all)
               
                List {
                    if self.loading {
                        ForEach(1..<10) { _ in
                            MissionCell(mission: LaunchModel(id: "", launch_date_utc: "2020-11-21T17:17:00.000Z", links: nil, mission_name: "#################"))
                                .listRowBackground(Color("navy-blue"))
                                .redacted(reason: .placeholder)
                        }
                    } else {
                        ForEach(self.launchesPast, id:\.id) { mission in
                            if let mission = mission {
                                NavigationLink(destination: MissionDetailView(mission: mission)) {
                                    MissionCell(mission: mission)
                                    
                                        
                                }.listRowBackground(Color("navy-blue"))
                            }
                        }
                    }

                }
            }
            
            .navigationBarTitle("Missions")
        }
        
    }
}

struct MissionsView_Previews: PreviewProvider {
    static var previews: some View {
        MissionsView(launchesPast: [LaunchModel](), loading: false)
    }
}

struct MissionCell: View {
    let mission: LaunchModel
    
    @ObservedObject var imageLoaderVM: ImageLoaderViewModel
    
    init(mission: LaunchModel) {
        self.mission = mission
        self.imageLoaderVM = ImageLoaderViewModel()
        if let imageUrl = mission.links?.mission_patch_small {
            self.imageLoaderVM.downloadImage(url: imageUrl)
        }
        
    }
    
    var body: some View {
        HStack {
            
            if let image = self.imageLoaderVM.downloadedImage {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.black)
            } else {
                VStack(alignment: .center) {
                    Image("rocket")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color("dark-gray"))
                }
                .frame(width: 40, height: 40, alignment: .center)
                .background(Color("light-gray"))
                .cornerRadius(50)
            }
            
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text(mission.mission_name ?? "")
                    .foregroundColor(Color.white)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                
                if let launchDate = mission.launch_date_utc {
                    Text(Date.dateFormatter(time: launchDate))
                        .foregroundColor(Color("light-gray"))
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                }
            }
            
        }
    }    
}



