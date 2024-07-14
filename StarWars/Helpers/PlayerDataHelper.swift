//
//  PlayerDataHelper.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import Foundation

class PlayerDataHelper {
    
    func populateScores(players: inout [Player], matches: [Match]) {
        var playersDict = Dictionary<Int, Player>()
        playersDict.reserveCapacity(players.count)
        
        players.forEach { response in
            playersDict[response.id] = response
        }
        
        matches.forEach { match in
            let player1 = playersDict[match.player1.id]
            let player2 = playersDict[match.player2.id]
            
            if match.player1.score > match.player2.score {
                player1?.score += 3
            }
            else if match.player1.score < match.player2.score {
                player2?.score += 3
            }
            else {
                player1?.score += 1
                player2?.score += 1
            }
            
            player1?.totalScore += match.player1.score
            player2?.totalScore += match.player2.score
            
            player1?.matches.append(match.id)
            player2?.matches.append(match.id)
        }
        
        let result = players.sorted {
            if $0.score == $1.score {
                return $0.totalScore > $1.totalScore
            }
            else {
                return $0.score > $1.score
            }
        }
        players = result
    }
    
    func getPlayers() async throws -> [Player] {
        let urlRequest = PlayerNetworkLayerUtility.getPlayersRequest()
        
        let playerResponse: [PlayerResponse]? = try await APICaller.shared.get(urlRequest)
        
        if let playerResponse {
            var players = Array<Player>()
            players.reserveCapacity(playerResponse.count)
            
            playerResponse.forEach { response in
                let player = Player(id: response.id, name: response.name, icon: response.icon)
                players.append(player)
            }
            return players
        }
        
        return []
    }
    
    func getMatches() async throws -> [Match] {
        
        let urlRequest = PlayerNetworkLayerUtility.getMatchesRequest()
        
        let matchResponse: [MatchResponse]? = try await APICaller.shared.get(urlRequest)
        
        if let matchResponse {
            var matches = Array<Match>()
            matches.reserveCapacity(matchResponse.count)
            
            matchResponse.forEach { response in
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
