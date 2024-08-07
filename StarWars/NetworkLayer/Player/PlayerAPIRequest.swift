//
//  PlayerAPIRequest.swift
//  StarWars
//
//  Created by Arun on 07/08/24.
//

import Foundation

enum PlayerAPIRequest {
    case getPlayers
}

extension PlayerAPIRequest: RestAPIRequest {
    
    var path: String {
        switch self {
        case .getPlayers:
            "getPlayerList"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPlayers:
            .get
        }
    }
}
