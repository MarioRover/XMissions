//
//  APIModel.swift
//  XMission
//
//  Created by Hossein Akbari on 1/28/1400 AP.
//

import SwiftUI



struct APIResponse: Decodable {
    let company: CompanyStruct?
}

struct CompanyStruct: Decodable {
    let ceo: String
    let coo: String
    let cto: String
    let cto_propulsion: String
    let employees: Int
    let founded: Int
    let founder: String
    let headquarters: Headquarters
    let links: Links
    let summary: String
    let valuation: Double
}

struct Headquarters: Decodable {
    let address: String
    let city: String
    let state: String
}

struct Links: Decodable {
    let website: String
    let twitter: String
    let flickr: String
}








