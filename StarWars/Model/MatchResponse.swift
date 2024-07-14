//
//  MatchResponse.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import Foundation

struct MatchResponse: Decodable {
    let match: Int
    let player1: Player1
    let player2: Player2
}

struct Player1: Decodable {
    let id: Int
    let score: Int
}

struct Player2: Decodable {
    let id: Int
    let score: Int
}
