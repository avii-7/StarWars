//
//  PlayerTableViewCell.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        playerImage.image = nil
        titleLabel.text = nil
        scoreLabel.text = nil
    }
}
