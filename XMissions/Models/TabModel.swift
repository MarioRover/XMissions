//
//  TabModel.swift
//  XMission
//
//  Created by Hossein Akbari on 1/28/1400 AP.
//

import SwiftUI

struct Tab {
    let label: String
    let image: UIImage
}

extension Tab {
    
    static func tabItems() -> [Tab] {
        let defaultImage = UIImage(systemName: "exclamationmark.triangle")!
        
        return [
            Tab(label: "Home", image: UIImage(named: "globe-americas") ?? defaultImage),
            Tab(label: "Vehicles", image: UIImage(named: "rocket") ?? defaultImage),
            Tab(label: "Missions", image: UIImage(named: "bullseye-arrow") ?? defaultImage),
            Tab(label: "News", image: UIImage(named: "satellite-dish") ?? defaultImage),
            Tab(label: "Company", image: UIImage(named: "industry-alt") ?? defaultImage)
        ]
    }
}
