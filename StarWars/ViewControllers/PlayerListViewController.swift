//
//  PlayerListViewController.swift
//  StarWars
//
//  Created by Arun on 12/07/24.
//

import UIKit
import SDWebImage

class PlayerListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var players = [Player]()
    
    private var matches = [Match]()
    
    private let helper = ScoreHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
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
            
            tableView.reloadData()
            stopAnimation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Star Wars Blaster Tournament"
    }
    
    private func startAnimation() {
        activityIndicator.isHidden = false
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func stopAnimation() {
        activityIndicator.isHidden = true
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? PlayerMatchDetailViewController
        
        if
            let vc,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            let selectedPlayer = players[selectedIndexPath.row]
            selectedPlayer.matches = selectedPlayer.matches.sorted(by: >)
            vc.selectedPlayer = selectedPlayer
            
            var playersDictionary = Dictionary<Int, Player>(minimumCapacity: players.count)
            players.forEach { playersDictionary[$0.id] = $0 }
            
            var matchesDictionary = Dictionary<Int, Match>(minimumCapacity: matches.count)
            matches.forEach { matchesDictionary[$0.id] = $0 }
            
            vc.playersDict = playersDictionary
            vc.matchesDict = matchesDictionary
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
        
        let url = URL(string: players[indexPath.row].icon)
        cell.playerImage.sd_setImage(with: url)
        cell.scoreLabel.text = "\(players[indexPath.row].score)"
        cell.titleLabel.text = players[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

