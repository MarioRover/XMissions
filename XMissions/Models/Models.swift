//
//  Models.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/13/1400 AP.
//

import SwiftUI

let defaultImage = UIImage(systemName: "exclamationmark.triangle")!

struct Tab {
    let label: String
    let image: UIImage?
}

extension Tab {
    
    static func tabItems() -> [Tab] {
        
        return [
            Tab(label: "Home", image: UIImage(named: "globe-americas")),
            Tab(label: "Vehicles", image: UIImage(named: "rocket")),
            Tab(label: "Missions", image: UIImage(named: "bullseye-arrow")),
            Tab(label: "News", image: UIImage(named: "satellite-dish")),
            Tab(label: "Company", image: UIImage(named: "industry-alt"))
        ]
    }
}

struct Manager {
    let id = UUID()
    let label: String
    let definition: String
    let name : String
}

struct CompanyInfo {
    let label: String
    let image: UIImage?
    let value: String
}

struct AssetsImages: Identifiable {
    let id = UUID()
    let image: Image
}

extension AssetsImages {
    static func missions() -> [AssetsImages] {
        return [
            AssetsImages(image: Image("mission-1")),
            AssetsImages(image: Image("mission-2")),
            AssetsImages(image: Image("mission-3")),
            AssetsImages(image: Image("mission-4")),
            AssetsImages(image: Image("mission-5")),
            AssetsImages(image: Image("mission-6")),
        ]
    }
}


func currencyFormate(value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.usesGroupingSeparator = true
    formatter.maximumFractionDigits = 0
    formatter.numberStyle = .currency
    
    if let amount = formatter.string(from: value as NSNumber) {
        return amount
    } else {
        return ""
    }
}
