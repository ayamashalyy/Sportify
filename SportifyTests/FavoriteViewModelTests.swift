//
//  FavoriteViewModelTests.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 26/05/2024.
//

import XCTest
@testable import Sportify

class FavoriteViewModelTests: XCTestCase {
    
    var viewModel: FavoriteViewModel!
    var mockDatabase: MockDataBaseManager!
    
    override func setUp() {
        super.setUp()
        mockDatabase = MockDataBaseManager()
        viewModel = FavoriteViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        mockDatabase = nil
        super.tearDown()
    }
    
    func testFetchLeaguesFromDB() {
        let leagues = [
            LegueModel(league_key: 4, league_name: "UEFA Europa League", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/"),
            LegueModel(league_key: 1, league_name: "UEFA European Championship", league_logo: ""),
            LegueModel(league_key: 683, league_name: "UEFA Europa Conference League", league_logo: ""),
            LegueModel(league_key: 3, league_name: "UEFA Champions League", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png"),
            LegueModel(league_key: 633, league_name: "UEFA Nations League", league_logo: ""),
            LegueModel(league_key: 28, league_name: "World Cup", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/28_world-cup.png")
        ]
        
        leagues.forEach { mockDatabase.insertLeague(league: $0) }
        
        print("Leagues inserted: \(mockDatabase.getAllLeagues().count)")
        
    
        var leaguesDidChangeCalled = false
        viewModel.leaguesDidChange = {
            leaguesDidChangeCalled = true
        }
        viewModel.fetchLeaguesFromDB()
        

        print("Fetched leagues: \(viewModel.leagues.count)")
        
     
        XCTAssertTrue(leaguesDidChangeCalled)
        XCTAssertEqual(viewModel.leagues[0].league_name, "UEFA Europa League")
      
    }
    
//    func testDeleteLeague() {
//
//        let leagues = [
//            LegueModel(league_key: 4, league_name: "UEFA Europa League", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/"),
//            LegueModel(league_key: 1, league_name: "UEFA European Championship", league_logo: ""),
//            LegueModel(league_key: 683, league_name: "UEFA Europa Conference League", league_logo: ""),
//            LegueModel(league_key: 3, league_name: "UEFA Champions League", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png"),
//            LegueModel(league_key: 633, league_name: "UEFA Nations League", league_logo: ""),
//            LegueModel(league_key: 28, league_name: "World Cup", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/28_world-cup.png")
//        ]
//        
//        leagues.forEach { mockDatabase.insertLeague(league: $0) }
//        
//        viewModel.fetchLeaguesFromDB()
//        
//    
//        var leaguesDidChangeCalled = false
//        viewModel.leaguesDidChange = {
//            leaguesDidChangeCalled = true
//        }
//        viewModel.deleteLeague(league: leagues[0])
//        
//     
//        XCTAssertTrue(leaguesDidChangeCalled)
//        XCTAssertEqual(viewModel.leagues.count, leagues.count - 1)
//        XCTAssertFalse(viewModel.leagues.contains(where: { $0.league_name == "UEFA Europa League" }))
//    }
}
