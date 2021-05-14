//
//  MissionDetailViewModel.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/23/1400 AP.
//

import Combine

class MissionDetailViewModel: ObservableObject {
    
    let id: String
    @Published var mission: LaunchModel?
    @Published var loading = false
    
    init(id: String) {
        self.id = id
    }
    
    func getMissionDetail() {
        self.loading.toggle()
        
        APIService.getMissionDetail(id: self.id) { data in
            if let data = data, let mission = data.launch {
                self.mission = mission
            }
            
            self.loading.toggle()
        }
    }
}
