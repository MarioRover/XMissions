//
//  MissionsView.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/15/1400 AP.
//

import SwiftUI

struct MissionsView: View {
    
    @State var launchesPast: [LaunchModel]

    
    var body: some View {
        
        ZStack {
            Color("navy-blue").edgesIgnoringSafeArea(.all)
            
            List {
                ForEach(self.launchesPast, id:\.id) { mission in
                    Text(mission.mission_name ?? "UnKnown")
                }
            }
        }
    }
}

struct MissionsView_Previews: PreviewProvider {
    static var previews: some View {
        MissionsView(launchesPast: [LaunchModel]())
    }
}
