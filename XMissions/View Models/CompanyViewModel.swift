//
//  CompanyViewModel.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import SwiftUI

class CompanyViewModel: ObservableObject {
    
    @Published var company: CompanyModel
    @Published var managers = [Manager]()
    @Published var companyInfo = [CompanyInfo]()
    @Published var companySocial = [CompanyInfo]()
    
    init(company: CompanyModel) {
        self.company = company
        createPageItems()
    }
    
    private func createPageItems() {
        
        self.managers.append(Manager(label: "CEO", definition: "Chief executive officer", name: company.ceo ?? ""))
        self.managers.append(Manager(label: "COO", definition: "Chief operating officer", name: company.coo ?? ""))
        self.managers.append(Manager(label: "CTO", definition: "Chief technology officer", name: company.cto ?? ""))
        self.managers.append(Manager(label: "Propulsion", definition: "", name: company.cto_propulsion ?? ""))
        
        self.companyInfo.append(CompanyInfo(label: "Valuation", image: UIImage(named: "sack-dollar"), value: currencyFormate(value: company.valuation ?? 0)))
        self.companyInfo.append(CompanyInfo(label: "Employees", image: UIImage(named: "user-friends"), value: String(company.employees ?? 0)))
        self.companyInfo.append(CompanyInfo(label: "Address", image: UIImage(named: "location"), value: String("\(company.headquarters?.city! ?? ""), \(company.headquarters?.state! ?? "")")))
        
        self.companySocial.append(CompanyInfo(label: "Website", image: UIImage(named: "globe"), value: company.links?.website ?? ""))
        self.companySocial.append(CompanyInfo(label: "Flickr", image: UIImage(named: "flickr"), value: company.links?.flickr ?? ""))
        self.companySocial.append(CompanyInfo(label: "Twitter", image: UIImage(named: "twitter"), value: company.links?.twitter ?? ""))
        
    }

}

