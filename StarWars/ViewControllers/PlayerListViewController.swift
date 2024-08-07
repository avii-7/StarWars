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
    
    private var players = [Player]()
    
    private var matches = [Match]()
    
    private let helper = ScoreHelper()
    
    private let playerResource = PlayerResource()
    
    private let matchResource = MatchResource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    private func fetchData() {
        
        Task { @MainActor in
            
            var players = try await playerResource.getPlayerList()
            let matches = try await matchResource.getMatchList()
            
            helper.populateScores(players: &players, matches: matches)
            
            self.players = players
            self.matches = matches
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Star Wars Blaster Tournament"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? PlayerMatchDetailViewController
        
        if
            let vc,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            vc.selectedPlayer = players[selectedIndexPath.row]
            
            var playersDictionary = Dictionary<Int, Player>()
            players.forEach { playersDictionary[$0.id] = $0 }
            
            var matchesDictionary = Dictionary<Int, Match>()
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

