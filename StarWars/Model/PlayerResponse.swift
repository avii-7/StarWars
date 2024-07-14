//
//  PlayerResponse.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import Foundation

struct PlayerResponse: Decodable {
    let id: Int
    let name: String
    let icon: String
}
