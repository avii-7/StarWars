//
//  MatchDetailViewController.swift
//  StarWars
//
//  Created by Arun on 14/07/24.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    private let selectedPlayer: Player
    
    private var playersDict = Dictionary<Int, Player>()
    
    private var matchesDict = Dictionary<Int, Match>()
    
    private let matches: [Match]
    
    private let players: [Player]
    
    init?(coder: NSCoder, selectedPlayer: Player, matches: [Match], players: [Player]) {
        self.selectedPlayer = selectedPlayer
        self.matches = matches
        self.players = players
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    
    func prepareData() {
        // PlayerDictionary for displaying opponent name in Detail Screen.
        playersDict = Dictionary<Int, Player>(minimumCapacity: players.count)
        players.forEach { playersDict[$0.id] = $0 }
        
        // MatchesDictionary for retrieving both players scores.
        matchesDict = Dictionary<Int, Match>(minimumCapacity: matches.count)
        matches.forEach { matchesDict[$0.id] = $0 }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem?.title = "Back"
        title = selectedPlayer.name
    }
}

extension MatchDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedPlayer.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerDetail", for: indexPath) as? MatchDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let matchId = selectedPlayer.matches[indexPath.row]
        
        guard let match = matchesDict[matchId] else { return cell }
        
        var player1Name = "", player2Name = ""
        
        if let player1 = playersDict[match.player1.id] {
            player1Name = player1.name
        }
        
        if let player2 = playersDict[match.player2.id] {
            player2Name = player2.name
        }
        
        let player1Score = match.player1.score
        let player2Score = match.player2.score
        
        let bgColor = getBackgroundColor(for: match)
        
        let state = MatchDetails(
            player1Name: player1Name,
            player1Score: player1Score,
            player2Name: player2Name,
            player2Score: player2Score,
            backgroundColor: bgColor
        )
        
        cell.setState(state: state)
        
        return cell
    }
    
    private func getBackgroundColor(for match: Match) -> UIColor {
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
            return UIColor.systemGreen
        }
        else if myScore < opponentScore {
            return UIColor.systemRed
        }
        else {
            return UIColor.clear
        }
    }
}
