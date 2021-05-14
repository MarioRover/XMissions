//
//  APIModel.swift
//  XMission
//
//  Created by Hossein Akbari on 1/28/1400 AP.
//

import SwiftUI



struct APIResponse: Decodable {
    let company: CompanyModel?
    let launchesPast: [LaunchModel]?
}

struct CompanyModel: Decodable {
    let ceo: String?
    let coo: String?
    let cto: String?
    let cto_propulsion: String?
    let employees: Int?
    let founded: Int?
    let founder: String?
    let headquarters: Headquarters?
    let links: Links?
    let summary: String?
    let valuation: Double?
}

struct Headquarters: Decodable {
    let address: String?
    let city: String?
    let state: String?
}

struct Links: Decodable {
    let website: String?
    let twitter: String?
    let flickr: String?
}

struct LaunchModel: Decodable {
    let id: String?
    let launch_date_utc: String?
    let links: LinkModel?
    let mission_name: String?
}

struct LaunchSiteModel: Decodable {
    let site_name: String?
    let site_name_long: String?
}

struct LinkModel: Decodable {
    let article_link: String?
    let flickr_images: [String]?
    let mission_patch: String?
    let mission_patch_small: String?
    let reddit_campaign: String?
    let video_link: String?
    let wikipedia: String?
}

struct RocketModel: Decodable {
    let rocket_name: String?
}

struct MissionDetail: Decodable {
    let launch: LaunchModel?
}



