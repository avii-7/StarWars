//
//  MatchAPIRequest.swift
//  StarWars
//
//  Created by Arun on 07/08/24.
//

import Foundation

enum MatchAPIRequest {
    case getMatchList
}

extension MatchAPIRequest: RestAPIRequest {
    
    var path: String {
        switch self {
        case .getMatchList:
            "getMatchList"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMatchList:
                .get
        }
    }
}
