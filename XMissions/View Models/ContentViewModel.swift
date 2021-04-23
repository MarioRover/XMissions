//
//  ContentViewModel.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var selectedIndex = 0
    
    init() {
        getCompanyInfo()
    }
    
    private func getCompanyInfo() {
        print("⬇️ Fetch Data")
        APIService.getCompanyInfo { (data) in
            guard let company = data?.company else {
                print("❗️There's not company")
                return
            }
            
            CoreDataManager.shared.saveCompanyInfo(companyData: company)
        }
    }
}
