//
//  FavoriteViewModelTests.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 26/05/2024.
//

import XCTest
@testable import Sportify

class FavoriteViewModelTests: XCTestCase {
    
    var databaseManager: Database!
    
    
    override func setUpWithError() throws {
        databaseManager = MockDataBaseManager()
        
    }
    
    override func tearDownWithError() throws {
        databaseManager = nil
        
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
        
        leagues.forEach { databaseManager.insertLeague(league: $0) }
        
           var leaguesDidChangeCalled = false
           databaseManager.leaguesDidChange = {
               leaguesDidChangeCalled = true
           }
        print("Leagues inserted: \(databaseManager.getAllLeagues().count)")
    
        XCTAssertEqual(databaseManager.getAllLeagues()[0].league_name, "UEFA Europa League")
        XCTAssertEqual(databaseManager.getAllLeagues()[1].league_key, 1)
    }
    
    func testDeleteLeague() {
          let leagues = [
              LegueModel(league_key: 4, league_name: "UEFA Europa League", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/"),
              LegueModel(league_key: 1, league_name: "UEFA European Championship", league_logo: ""),
              LegueModel(league_key: 683, league_name: "UEFA Europa Conference League", league_logo: ""),
              LegueModel(league_key: 3, league_name: "UEFA Champions League", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png"),
              LegueModel(league_key: 633, league_name: "UEFA Nations League", league_logo: ""),
              LegueModel(league_key: 28, league_name: "World Cup", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/28_world-cup.png")
          ]
          
          leagues.forEach { databaseManager.insertLeague(league: $0) }
          
       
          var leaguesDidChangeCalled = false
          databaseManager.leaguesDidChange = {
              leaguesDidChangeCalled = true
          }

          databaseManager.deleteLeagueFromFavorites(league: leagues[0])

          XCTAssertTrue(leaguesDidChangeCalled)
          XCTAssertEqual(databaseManager.getAllLeagues().count, leagues.count - 1)
          XCTAssertFalse(databaseManager.getAllLeagues().contains(where: { $0.league_name == "UEFA Europa League" }))
      }
  }

