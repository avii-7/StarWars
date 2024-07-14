//
//  PlayerNetworkLayerUtility.swift
//  StarWars
//
//  Created by Arun on 14/07/24.
//

import Foundation

struct PlayerNetworkLayerUtility {

    static func getPlayersRequest() -> URLRequest {
        let url = URL(string: "https://www.jsonkeeper.com/b/IKQQ")!
        let request = URLRequest(url: url)
        return request
    }
    
    static func getMatchesRequest() -> URLRequest {
        let url = URL(string: "https://www.jsonkeeper.com/b/JNYL")!
        let request = URLRequest(url: url)
        return request
    }
}
