////
////  FavoriteViewModelTests.swift
////  SportifyTests
////
////  Created by Marim Mohamed Mohamed Yacout on 26/05/2024.
////
//
//import XCTest
//@testable import Sportify
//
//// Mock DatabaseManager to simulate database interactions
//class MockDataBaseManager: DataBaseManager {
//    var leagues: [LegueModel] = []
//
//    override func getAllLeagues() -> [LegueModel] {
//        return leagues
//    }
//
//    override func deleteLeagueFromFavorites(league: LegueModel) {
//        if let index = leagues.firstIndex(where: { $0.id == league.id }) {
//            leagues.remove(at: index)
//        }
//    }
//}
//
//// Unit test class for FavoriteViewModel
//class FavoriteViewModelTests: XCTestCase {
//    var viewModel: FavoriteViewModel!
//    var mockDataBaseManager: MockDataBaseManager!
//
//    override func setUp() {
//        super.setUp()
//        mockDataBaseManager = MockDataBaseManager()
//        DataBaseManager.shared = mockDataBaseManager
//        viewModel = FavoriteViewModel()
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        mockDataBaseManager = nil
//        super.tearDown()
//    }
//
//    func testFetchLeaguesFromDB() {
//        // Given
//        let league1 = LegueModel(id: 1, name: "League 1")
//        let league2 = LegueModel(id: 2, name: "League 2")
//        mockDataBaseManager.leagues = [league1, league2]
//
//        let expectation = self.expectation(description: "leaguesDidChange called")
//
//        viewModel.leaguesDidChange = {
//            expectation.fulfill()
//        }
//
//        // When
//        viewModel.fetchLeaguesFromDB()
//
//        // Then
//        waitForExpectations(timeout: 1, handler: nil)
//        XCTAssertEqual(viewModel.leagues.count, 2)
//        XCTAssertEqual(viewModel.leagues[0].league_name, "League 1")
//        XCTAssertEqual(viewModel.leagues[1].league_name, "League 2")
//    }
//
//    func testDeleteLeague() {
//        // Given
//        let league1 = LegueModel(id: 1, name: "League 1")
//        let league2 = LegueModel(id: 2, name: "League 2")
//        mockDataBaseManager.leagues = [league1, league2]
//
//        let expectation = self.expectation(description: "leaguesDidChange called")
//
//        viewModel.leaguesDidChange = {
//            expectation.fulfill()
//        }
//
//        // When
//        viewModel.deleteLeague(league: league1)
//
//        // Then
//        waitForExpectations(timeout: 1, handler: nil)
//        XCTAssertEqual(viewModel.leagues.count, 1)
//        XCTAssertEqual(viewModel.leagues[0].league_name, "League 2")
//    }
//}
//
//// Dummy implementation to make the code compile
//// Replace this with the actual implementation of DataBaseManager in your project
//class DataBaseManager {
//    static var shared = DataBaseManager()
//    func getAllLeagues() -> [LegueModel] { return [] }
//    func deleteLeagueFromFavorites(league: LegueModel) {}
//}
//
//// Ensure this is replaced with the actual LegueModel from your main project
//struct LegueModel: Equatable {
//    var id: Int
//    var name: String
//}
