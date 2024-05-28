//
//  LeagueDetailsMockNetworkTest.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 29/05/2024.
//
import XCTest
@testable import Sportify

class LeagueDetailsMockNetworkTest: XCTestCase {
    var networkService: NetworkService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        networkService = mockNetworkService
    }

    func testFetchLeagueDetailsDataSuccess() {
        let leagueDetailsJsonString = """
        {
            "success": 1,
            "result": [
                {
                    "event_key": 101,
                    "event_date": "2024-05-24",
                    "event_time": "18:00",
                    "event_home_team": "Team A",
                    "home_team_key": 1,
                    "event_away_team": "Team B",
                    "away_team_key": 2,
                    "league_name": "Premier League",
                    "league_key": 1,
                    "home_team_logo": "home_team_logo_url",
                    "away_team_logo": "away_team_logo_url",
                    "event_final_result": "2-1"
                }
            ]
        }
        """
        mockNetworkService.mockData = leagueDetailsJsonString.data(using: .utf8)
        mockNetworkService.shouldReturnError = false

        var result: Result<LegueDetailsResponse, Error>?
        
        networkService.fetchData(from: "test_url", responseType: LegueDetailsResponse.self) { response in
            result = response
        }
        
        switch result {
        case .success(let leagueDetailsResponse):
            XCTAssertEqual(leagueDetailsResponse.success, 1)
            XCTAssertEqual(leagueDetailsResponse.result?.first?.event_key, 101)
            XCTAssertEqual(leagueDetailsResponse.result?.first?.event_home_team, "Team A")
            XCTAssertEqual(leagueDetailsResponse.result?.first?.event_final_result, "2-1")
        case .failure(let error):
            XCTFail("Expected success, but got failure with error: \(error)")
        case .none:
            XCTFail("No result returned")
        }
    }

    func testFetchLeagueDetailsDataFailure() {
        mockNetworkService.mockData = nil
        mockNetworkService.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockNetworkService.shouldReturnError = true

        var result: Result<LegueDetailsResponse, Error>?
        
        networkService.fetchData(from: "test_url", responseType: LegueDetailsResponse.self) { response in
            result = response
        }
        
        switch result {
        case .success(_):
            XCTFail("Expected failure, but got success")
        case .failure(let error):
            XCTAssertNotNil(error)
        case .none:
            XCTFail("No result returned")
        }
    }
}
