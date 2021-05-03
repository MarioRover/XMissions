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
    @Published var companyInfo = [CompanyInfo]()

    init() {
        getComapnyData()
    }
    
    private func getComapnyData() {
        CoreDataManager.shared.fetchCompanyInfo { (data) in
            if let data = data {
                self.company = data
                self.managers.append(Manager(label: "CEO", definition: "Chief executive officer", name: data.ceo ?? ""))
                self.managers.append(Manager(label: "COO", definition: "Chief operating officer", name: data.coo ?? ""))
                self.managers.append(Manager(label: "CTO", definition: "Chief technology officer", name: data.cto ?? ""))
                self.managers.append(Manager(label: "Propulsion", definition: "", name: data.cto_propulsion ?? ""))
                
                self.companyInfo.append(CompanyInfo(label: "Valuation", image: UIImage(named: "sack-dollar"), value: currencyFormate(value: data.valuation)))
                self.companyInfo.append(CompanyInfo(label: "Employees", image: UIImage(named: "user-friends"), value: String(data.employees)))
                self.companyInfo.append(CompanyInfo(label: "Address", image: UIImage(named: "location"), value: String("\(data.city!), \(data.state!)")))
            }
        }
    }
}

