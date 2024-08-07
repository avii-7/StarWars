//
//  Player.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import Foundation

class Player {
    
    let id: Int
    let name: String
    let icon: String
    // This will contains the score for matches wins and tie.
    var score = 0
    // This will contains the total score for all the matches player with other players.
    var totalScore = 0
    
    var matches: [Int] = []
    
    init(
        id: Int,
        name: String,
        icon: String,
        score: Int = 0,
        totalScore: Int = 0
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.score = score
        self.totalScore = totalScore
    }
}

extension Player: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}
