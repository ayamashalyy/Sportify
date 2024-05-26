//
//  FavoriteViewModelTests.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 26/05/2024.
//

//import XCTest
//@testable import Sportify
//
//class FavoriteViewModelTests: XCTestCase {
//    
//    var viewModel: FavoriteViewModel!
//    var mockDatabaseManager: MockDataBaseManager!
//    
//    override func setUp() {
//        super.setUp()
//        mockDatabaseManager = MockDataBaseManager()
//        swizzleDatabaseManagerShared()
//        viewModel = FavoriteViewModel()
//    }
//    
//    override func tearDown() {
//        viewModel = nil
//        mockDatabaseManager = nil
//        super.tearDown()
//    }
//    
//    func swizzleDatabaseManagerShared() {
//        let originalSelector = #selector(getter: DataBaseManager.shared)
//        let swizzledSelector = #selector(getter: mock_shared)
//        
//        let originalMethod = class_getClassMethod(DataBaseManager.self, originalSelector)
//        let swizzledMethod = class_getInstanceMethod(FavoriteViewModelTests.self, swizzledSelector)
//        
//        method_exchangeImplementations(originalMethod!, swizzledMethod!)
//    }
//    
//    @objc var mock_shared: DataBaseManager {
//        return mockDatabaseManager as! DataBaseManager
//    }
//    
//    func testFetchLeaguesFromDB() {
//        // Given
//        let league = LegueModel(league_key: 1, league_name: "Test League", league_logo: "logo_url")
//        mockDatabaseManager.insertLeague(league: league)
//        
//        // When
//        viewModel.fetchLeaguesFromDB()
//        
//        // Then
//        XCTAssertEqual(viewModel.leagues.count, 1)
//        XCTAssertEqual(viewModel.leagues.first?.league_name, "Test League")
//    }
//    
//    func testDeleteLeague() {
//        // Given
//        let league1 = LegueModel(league_key: 1, league_name: "Test League 1", league_logo: "logo_url_1")
//        let league2 = LegueModel(league_key: 2, league_name: "Test League 2", league_logo: "logo_url_2")
//        mockDatabaseManager.insertLeague(league: league1)
//        mockDatabaseManager.insertLeague(league: league2)
//        
//        // When
//        viewModel.deleteLeague(league: league1)
//        
//        // Then
//        XCTAssertEqual(viewModel.leagues.count, 1)
//        XCTAssertEqual(viewModel.leagues.first?.league_name, "Test League 2")
//    }
//    
//    func testLeaguesDidChangeCallback() {
//        // Given
//        let expectation = self.expectation(description: "Leagues did change callback")
//        viewModel.leaguesDidChange = {
//            expectation.fulfill()
//        }
//        
//        let league = LegueModel(league_key: 1, league_name: "Test League", league_logo: "logo_url")
//        mockDatabaseManager.insertLeague(league: league)
//        
//        // When
//        viewModel.fetchLeaguesFromDB()
//        
//        // Then
//        waitForExpectations(timeout: 1.0, handler: nil)
//    }
//}
