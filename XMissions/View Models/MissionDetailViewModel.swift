//
//  MissionDetailViewModel.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/23/1400 AP.
//

import Foundation

class MissionDetailViewModel: ObservableObject {
    
    let id: String
    @Published var mission: LaunchModel_2?
    @Published var loading = false
    @Published var isConnectionIssue = false
    
    init(id: String) {
        self.id = id
    }
    
    func getMissionDetail() {
        self.loading.toggle()
        
        APIService.getMissionDetail(id: self.id) { (data , error) in
            if let data = data, let mission = data.launch, error == .none {
                self.mission = mission
            } else if error == .network {
                self.isConnectionIssue = true
                print("❗️There's not response")
            }
            
            self.loading.toggle()
        }
    }
}
