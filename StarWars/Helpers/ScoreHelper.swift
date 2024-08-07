//
//  ScoreHelper.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import Foundation

class ScoreHelper {
    
    func populateScores(players: inout [Player], matches: [Match]) {
        
        var playersDict = Dictionary<Int, Player>(minimumCapacity: players.count)
        
        players.forEach { player in
            playersDict[player.id] = player
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
                $0.totalScore > $1.totalScore
            }
            else {
                $0.score > $1.score
            }
        }
        
        players = result
    }
}
