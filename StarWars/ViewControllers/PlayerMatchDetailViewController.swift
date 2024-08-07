//
//  PlayerMatchDetailViewController.swift
//  StarWars
//
//  Created by Arun on 14/07/24.
//

import UIKit

class PlayerMatchDetailViewController: UIViewController {
    
    var selectedPlayer: Player?
    
    var playersDict = Dictionary<Int, Player>()
    
    var matchesDict = Dictionary<Int, Match>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem?.title = "Back"
        title = selectedPlayer?.name
    }
}

extension PlayerMatchDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedPlayer?.matches.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerDetail", for: indexPath) as? MatchDetailTableViewCell else {
            return UITableViewCell()
        }
        
        guard let selectedPlayer else { return cell }
        
        let matchId = selectedPlayer.matches[indexPath.row]
        
        guard let match = matchesDict[matchId] else { return cell }
        
        let player1Score = match.player1.score
        let player2Score = match.player2.score
        
        cell.setScore(player1: player1Score, player2: player2Score)
        
        if let player1 = playersDict[match.player1.id] {
            cell.setPlayer1Name(name: player1.name)
        }
        
        if let player2 = playersDict[match.player2.id] {
            cell.setPlayer2Name(name: player2.name)
        }
        
        cell.setBackgroundColor(selectedPlayerId: selectedPlayer.id, match)
        
        return cell
    }
}

