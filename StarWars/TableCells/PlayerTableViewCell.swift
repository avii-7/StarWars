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
    
    func setState(model player: Player) {
        
        let iconUrl = player.icon
        
        ImageUtility.shared.setImageAsync(urlString: iconUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.playerImage.image = image
            }
        }
        
        scoreLabel.text = "\(player.score)"
        titleLabel.text = player.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerImage.image = nil
    }
}
