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
    private var database: DataBaseManager
       
       init(database: DataBaseManager = DataBaseManager.shared) {
           self.database = database
       }
    func fetchLeaguesFromDB() {
        leagues = DataBaseManager.shared.getAllLeagues()
        leaguesDidChange?()
    }
  
    
    func deleteLeague(league: LegueModel) {
            DataBaseManager.shared.deleteLeagueFromFavorites(league: league)
            fetchLeaguesFromDB()
        }
    
    
    
}
