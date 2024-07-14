//
//  PlayerMatchDetailViewController.swift
//  StarWars
//
//  Created by Arun on 14/07/24.
//

import UIKit

class PlayerMatchDetailViewController: UIViewController {
    
    var selectedPlayer: Player?
    
    var playersDict: Dictionary<Int, Player>?
    
    var matchesDict: Dictionary<Int, Match>?
    
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
        
        if
            let selectedPlayer,
            let matchesDict,
            let playersDict {
            
            let matchId = selectedPlayer.matches[indexPath.row]
            
            if let match = matchesDict[matchId] {
                let player1Score = match.player1.score
                let player2Score = match.player2.score
                cell.scoreLabel.text = "\(player1Score) - \(player2Score)"
                
                if let player1 = playersDict[match.player1.id] {
                    cell.player1NameLabel.text = player1.name
                }
                
                if let player2 = playersDict[match.player2.id] {
                    cell.player2NameLabel.text = player2.name
                }
                
                // BG Color
                
                let myScore: Int
                let opponentScore: Int
                
                if selectedPlayer.id == match.player1.id {
                    myScore = match.player1.score
                    opponentScore = match.player2.score
                }
                else {
                    myScore = match.player2.score
                    opponentScore = match.player1.score
                }
                
                if myScore > opponentScore {
                    cell.contentView.backgroundColor = UIColor.green
                }
                else if myScore < opponentScore {
                    cell.contentView.backgroundColor = UIColor.red
                }
            }
        }
        
        return cell
    }
}

