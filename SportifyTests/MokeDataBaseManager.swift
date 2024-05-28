//
//  SportifyTests
//
//  Created by aya on 26/05/2024.
//

import Foundation

struct LegueModel {
    var league_key: Int
    var league_name: String
    var league_logo: String
   
}


protocol Database {
    func insertLeague(league: LegueModel)
    func getAllLeagues() -> [LegueModel]
    func deleteLeagueFromFavorites(league: LegueModel)
}

class MockDataBaseManager: Database {
    private var leagues: [LegueModel] = []
    
    func insertLeague(league: LegueModel) {
        leagues.append(league)
    }
    
    func getAllLeagues() -> [LegueModel] {
        return leagues
    }
    
    func deleteLeagueFromFavorites(league: LegueModel) {
        leagues.removeAll(where: { $0.league_key == league.league_key })
    }
}
