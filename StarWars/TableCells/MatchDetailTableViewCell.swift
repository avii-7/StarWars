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
    
    func setState(state: MatchDetails) {
        
        player1NameLabel.text = state.player1Name
        player2NameLabel.text = state.player2Name
        
        scoreLabel.text = "\(state.player1Score) - \(state.player2Score)"
        
        contentView.backgroundColor = state.backgroundColor
    }
}

