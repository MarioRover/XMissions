//
//  CompanyViewModel.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import SwiftUI

class CompanyViewModel: ObservableObject {
        
    @Published var company: Company?
    @Published var managers = [Manager]()

    init() {
        getComapnyData()
    }
    
    private func getComapnyData() {
        CoreDataManager.shared.fetchCompanyInfo { (data) in
            if let data = data {
                self.company = data
                self.managers.append(Manager(label: "CEO", name: data.ceo ?? ""))
                self.managers.append(Manager(label: "COO", name: data.coo ?? ""))
                self.managers.append(Manager(label: "CTO", name: data.cto ?? ""))
                self.managers.append(Manager(label: "Propulsion", name: data.cto_propulsion ?? ""))
            }
        }
        
    }
    
}


struct Manager {
    let id = UUID()
    let label: String
    let name : String
}
