//
//  MatchResource.swift
//  StarWars
//
//  Created by Arun on 07/08/24.
//

import Foundation

class MatchResource {
    
    func getMatchList() async throws -> [Match] {
        let request = MatchAPIRequest.getMatchList
        let matchResponseList: [MatchResponse]? = try await HttpUtility.shared.hit(request)
        
        if let matchResponseList {
            var matches = Array<Match>()
            matches.reserveCapacity(matchResponseList.count)
            
            matchResponseList.forEach { response in
                let match = Match(
                    id: response.match,
                    player1: MatchPlayer(id: response.player1.id, score: response.player1.score),
                    player2: MatchPlayer(id: response.player2.id, score: response.player2.score)
                )
                matches.append(match)
            }
            
            return matches
        }
        
        return []
    }
}
