//
//  FavoriteViewModel.swift
//  Sportify
//
//  Created by aya on 25/05/2024.
//

import Foundation


class FavoriteViewModel {
    var leagues: [LegueModel] = []
    var leaguesDidChange: (() -> Void)?
 
    func fetchLeaguesFromDB() {
        leagues = DataBaseManager.shared.getAllLeagues()
        leaguesDidChange?()
    }
  
    func deleteLeague(at index: Int) {
        let league = leagues[index]
        DataBaseManager.shared.deleteLeagueItem(league: league)
        fetchLeaguesFromDB()
    }
    
    
    
    
}
