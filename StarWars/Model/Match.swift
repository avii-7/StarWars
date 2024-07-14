//
//  Match.swift
//  StarWars
//
//  Created by Arun on 14/07/24.
//

import Foundation

struct Match {
    let id: Int
    let player1: MatchPlayer
    let player2: MatchPlayer
}

struct MatchPlayer {
    let id: Int
    let score: Int
}
