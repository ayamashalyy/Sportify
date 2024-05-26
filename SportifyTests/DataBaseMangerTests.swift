//
//  DataBaseMangerTests.swift
//  SportifyTests
//
//  Created by aya on 26/05/2024.
//

import XCTest
@testable import Sportify
import CoreData

final class DataBaseMangerTests: XCTestCase {
    var databaseManager: Database!
    
    
    override func setUpWithError() throws {
        databaseManager = MockDataBaseManager()
        
    }
    
    override func tearDownWithError() throws {
        databaseManager = nil
        
    }
    
    func testInsertLeague() {
        let league = LegueModel(league_key: 1, league_name: "Premier League", league_logo: "premier_logo")
        databaseManager.insertLeague(league: league)
        let leagues = databaseManager.getAllLeagues()
        XCTAssertEqual(leagues.count, 1, "There should be one league in the database")
        XCTAssertEqual(leagues.first?.league_key, league.league_key)
    }
    
    func testGetAllLeagues() {
        let league1 = LegueModel(league_key: 1, league_name: "Premier League", league_logo: "premier_logo")
        let league2 = LegueModel(league_key: 2, league_name: "La Liga", league_logo: "laliga_logo")
        databaseManager.insertLeague(league: league1)
        databaseManager.insertLeague(league: league2)
        let leagues = databaseManager.getAllLeagues()
        XCTAssertEqual(leagues.count, 2, "There should be two leagues in the database")
    }
    
    func testDeleteLeagueFromFavorites() {
        let league = LegueModel(league_key: 1, league_name: "Premier League", league_logo: "premier_logo")
        databaseManager.insertLeague(league: league)
        databaseManager.deleteLeagueFromFavorites(league: league)
        let leagues = databaseManager.getAllLeagues()
        XCTAssertEqual(leagues.count, 0, "There should be no leagues in the database")
    }


func testPerformanceExample() throws {
    self.measure {
    }
 }

 }
