//
//  APIService.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import Foundation

class APIService {
    
    enum ErrorType {
        case network
        case none
    }
    
    static func getInitialData(completion: @escaping (APIResponse?, ErrorType) -> ()) {
        Network.shared.apollo.fetch(query: InitialQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                if let companyObject = graphQLResult.data?.jsonObject {

                    guard let jsonData = try? JSONSerialization.data(withJSONObject: companyObject) else {
                        completion(nil, .none)
                        fatalError("Error Seriallize Response")
                    }
                    
                    guard let response = try? JSONDecoder().decode(APIResponse.self, from: jsonData) else {
                        completion(nil, .none)
                        fatalError("Error Decode Response")
                    }
                    
                    completion(response, .none)
                    
                } else {
                    print("Error in find object")
                    completion(nil, .none)
                }
            case .failure:
//                print(error)
                print("🚫 Request failed")
                completion(nil, .network)
            }
        }
    }
    
    static func getMissionDetail(id: String, completion: @escaping (MissionDetail?, ErrorType) -> ()) {
        
        Network.shared.apollo.fetch(query: MissionDetailQuery(id: id)) { result in
            switch result {
            case .success(let graphQLResult):
                if let responseObject = graphQLResult.data?.jsonObject {
                    
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: responseObject) else {
                        completion(nil, .none)
                        fatalError("Error Seriallize Response")
                    }
                    
                    guard let response = try? JSONDecoder().decode(MissionDetail.self, from: jsonData) else {
                        completion(nil, .none)
                        fatalError("Error Decode Response")
                    }
                    
                    completion(response, .none)
                    
                } else {
                    print("Error in find object")
                    completion(nil, .none)
                }
                
            case .failure:
//                print(error)
                print("🚫 Request failed")
                completion(nil, .network)
            }
        }
    }
    
}

