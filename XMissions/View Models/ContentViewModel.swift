//
//  ContentViewModel.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var selectedIndex = 0
    @Published var launchesPast = [LaunchModel]()
    @Published var company: CompanyModel?
    @Published var isConnectionIssue = false
    
    init() {
        getInitialData()
    }
    
    private func getInitialData() {
        print("⬇️ Fetch Data")
        APIService.getInitialData { (data, error) in
            if let data = data, error == .none {
                
                if let launchesPastData = data.launchesPast {
                    self.launchesPast = launchesPastData
                }
                
                if let companyData = data.company {
                    self.company = companyData
                }
                
            } else if error == .network {
                DispatchQueue.main.async {
                    self.isConnectionIssue = true
                }
                
                print("❗️There's not response")
            }
        }
    }
}
