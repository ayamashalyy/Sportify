//
//  MockNetwork.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 26/05/2024.
//
import XCTest
@testable import Sportify

class TeamsMockNetworkTest: XCTestCase {
    var networkService: NetworkService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        networkService = mockNetworkService
    }

    func testFetchTeamsDataSuccess() {
        let teamsJsonString = """
        {
            "success": 1,
            "result": [
                {
                    "team_key": 1,
                    "team_name": "Team A",
                    "team_logo": "logo_url",
                    "players": [
                        {
                            "player_key": 101,
                            "player_image": "player_image_url",
                            "player_name": "Player 1",
                            "player_number": "10",
                            "player_type": "Forward"
                        }
                    ],
                    "coaches": [
                        {
                            "coach_name": "Coach A"
                        }
                    ]
                }
            ]
        }
        """
        mockNetworkService.mockData = teamsJsonString.data(using: .utf8)
        mockNetworkService.shouldReturnError = false

        var result: Result<TeamsResponse, Error>?
        
        networkService.fetchData(from: "test_url", responseType: TeamsResponse.self) { response in
            result = response
        }
        
        switch result {
        case .success(let teamsResponse):
            XCTAssertEqual(teamsResponse.success, 1)
            XCTAssertEqual(teamsResponse.result?.first?.team_key, 1)
            XCTAssertEqual(teamsResponse.result?.first?.team_name, "Team A")
            XCTAssertEqual(teamsResponse.result?.first?.team_logo, "logo_url")
            
            XCTAssertEqual(teamsResponse.result?.first?.players?.first?.player_key, 101)
            XCTAssertEqual(teamsResponse.result?.first?.players?.first?.player_name, "Player 1")
            XCTAssertEqual(teamsResponse.result?.first?.players?.first?.player_number, "10")
            XCTAssertEqual(teamsResponse.result?.first?.players?.first?.player_type, "Forward")
            
            XCTAssertEqual(teamsResponse.result?.first?.coaches?.first?.coach_name, "Coach A")
        case .failure(let error):
            XCTFail("Expected success, but got failure with error: \(error)")
        case .none:
            XCTFail("No result returned")
        }
    }

    func testFetchTeamsDataFailure() {
        mockNetworkService.mockData = nil
        mockNetworkService.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockNetworkService.shouldReturnError = true

        var result: Result<TeamsResponse, Error>?
        
        networkService.fetchData(from: "test_url", responseType: TeamsResponse.self) { response in
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
