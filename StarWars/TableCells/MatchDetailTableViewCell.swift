//
//  MatchDetailTableViewCell.swift
//  StarWars
//
//  Created by Arun on 14/07/24.
//

import UIKit

class MatchDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private var player1NameLabel: UILabel!
    
    @IBOutlet var player2NameLabel: UILabel!
    
    @IBOutlet private var scoreLabel: UILabel!
    
    func setBackgroundColor(selectedPlayerId: Int, _ match: Match) {
        
        let myScore: Int
        let opponentScore: Int
        
        if selectedPlayerId == match.player1.id {
            myScore = match.player1.score
            opponentScore = match.player2.score
        }
        else {
            myScore = match.player2.score
            opponentScore = match.player1.score
        }
        
        if myScore > opponentScore {
            contentView.backgroundColor = UIColor.systemGreen
        }
        else if myScore < opponentScore {
            contentView.backgroundColor = UIColor.systemRed
        }
        else {
            contentView.backgroundColor = UIColor.clear
        }
    }
    
    func setScore(player1: Int, player2: Int) {
        scoreLabel.text = "\(player1) - \(player2)"
    }
    
    func setPlayer1Name(name: String) {
        player1NameLabel.text = name
    }
    
    func setPlayer2Name(name: String) {
        player2NameLabel.text = name
    }
}
