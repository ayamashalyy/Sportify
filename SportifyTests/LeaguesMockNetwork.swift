//
//  LeaguesMockNetwork.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 28/05/2024.
//

import XCTest
@testable import Sportify

class LeagueMockNetworkTest: XCTestCase {
    var networkService: NetworkService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        networkService = mockNetworkService
    }

    func testFetchLeagueDataSuccess() {
        let leagueJsonString = """
        {
            "success": 1,
            "result": [
                {
                    "league_key": 1,
                    "league_name": "Premier League",
                    "league_logo": "logo_url"
                }
            ]
        }
        """
        mockNetworkService.mockData = leagueJsonString.data(using: .utf8)
        mockNetworkService.shouldReturnError = false

        var result: Result<LegueResponse, Error>?
        
        networkService.fetchData(from: "test_url", responseType: LegueResponse.self) { response in
            result = response
        }
        
        switch result {
        case .success(let leagueResponse):
            XCTAssertEqual(leagueResponse.success, 1)
            XCTAssertEqual(leagueResponse.result?.first?.league_key, 1)
            XCTAssertEqual(leagueResponse.result?.first?.league_name, "Premier League")
            XCTAssertEqual(leagueResponse.result?.first?.league_logo, "logo_url")
        case .failure(let error):
            XCTFail("Expected success, but got failure with error: \(error)")
        case .none:
            XCTFail("No result returned")
        }
    }

    func testFetchLeagueDataFailure() {
        mockNetworkService.mockData = nil
        mockNetworkService.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockNetworkService.shouldReturnError = true

        var result: Result<LegueResponse, Error>?
        
        networkService.fetchData(from: "test_url", responseType: LegueResponse.self) { response in
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
