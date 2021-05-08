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
    
    init() {
        getInitialData()
    }
    
    private func getInitialData() {
        print("⬇️ Fetch Data")
        APIService.getInitialData { (data) in
            if let data = data {
                
                if let launchesPastData = data.launchesPast {
                    self.launchesPast = launchesPastData
                }
                
                if let companyData = data.company {
                    self.company = companyData
                }
                
            } else {
                print("❗️There's not response")
            }
        }
    }
}
