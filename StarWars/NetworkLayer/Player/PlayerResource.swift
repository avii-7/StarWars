//
//  PlayerResource.swift
//  StarWars
//
//  Created by Arun on 07/08/24.
//

import Foundation

class PlayerResource {
    
    func getPlayerList() async throws -> [Player] {
        let request = PlayerAPIRequest.getPlayers
        let playerResponseList: [PlayerResponse]? = try await HttpUtility.shared.hit(request)
        
        if let playerResponseList, playerResponseList.isEmpty == false {
            var players = Array<Player>()
            players.reserveCapacity(playerResponseList.count)
            
            playerResponseList.forEach { response in
                let player = Player(id: response.id, name: response.name, icon: response.icon)
                players.append(player)
            }
            return players
        }
        
        return []
    }
}
