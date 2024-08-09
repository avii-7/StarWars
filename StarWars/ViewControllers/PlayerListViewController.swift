//
//  PlayerListViewController.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import UIKit

class PlayerListViewController: UIViewController {
    
    @IBOutlet weak var playerListTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var players = [Player]()
    
    private var matches = [Match]()
    
    private let helper = ScoreHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animation(start: true)
        fetchData()
    }
    
    private func fetchData() {
        
        Task { @MainActor in
            
            let playerResource = PlayerResource()
            let matchResource = MatchResource()
            
            var players = try await playerResource.getPlayerList()
            let matches = try await matchResource.getMatchList()
            
            helper.populateScores(players: &players, matches: matches)
            
            self.players = players
            self.matches = matches
            
            playerListTableView.reloadData()
            animation(start: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Star Wars Blaster Tournament"
    }
        
    private func animation(start: Bool) {
        if start {
            activityIndicator.isHidden = false
            playerListTableView.isHidden = true
            activityIndicator.startAnimating()
        }
        else {
            activityIndicator.isHidden = true
            playerListTableView.isHidden = false
            activityIndicator.stopAnimating()
        }
    }
}

extension PlayerListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as? PlayerTableViewCell else {
            return UITableViewCell()
        }
        
        let model = players[indexPath.row]
        cell.setState(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PlayerListViewController {
    
    @IBSegueAction
    func makeMatchDetailViewController(coder: NSCoder) -> MatchDetailViewController? {
        
        let indexPath = playerListTableView.indexPathForSelectedRow
        
        guard let indexPath else { return nil }
        
        // Sorting the player matches in descending order for fulfilling Matches Screen 2nd requirement.
        let selectedPlayer = players[indexPath.row]
        selectedPlayer.matches = selectedPlayer.matches.sorted(by: >)
    
        let vc = MatchDetailViewController(coder: coder, selectedPlayer: selectedPlayer, matches: matches, players: players)
        return vc
    }
}
