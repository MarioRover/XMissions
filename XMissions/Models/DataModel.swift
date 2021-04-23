//
//  DataModel.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import Foundation

class CompanyModel {
    let ceo: String
    let coo: String
    let cto: String
    let cto_propulsion: String
    let employees: Int
    let founded: Int
    let summary: String
    
    init(company: CompanyStruct) {
        self.ceo = company.ceo
        self.coo = company.coo
        self.cto = company.cto
        self.cto_propulsion = company.cto_propulsion
        self.employees = company.employees
        self.founded = company.founded
        self.summary = company.summary
    }
}
