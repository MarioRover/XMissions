//
//  Apollo.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.spacex.land/graphql/")!)
}
