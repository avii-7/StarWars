//
//  MatchDetailTableViewCell.swift
//  StarWars
//
//  Created by Arun on 14/07/24.
//

import UIKit

class MatchDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var player1NameLabel: UILabel!
    
    @IBOutlet var player2NameLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = UIColor.clear
    }
}
