//
//  MockNetwork.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 26/05/2024.
//
import XCTest
import Alamofire
@testable import Sportify

import XCTest

class MockNetwork: XCTestCase {
    var networkService: NetworkService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        networkService = mockNetworkService!
    }

    func testFetchDataSuccess() {
      
        let jsonString = """
        {
            "success": 1,
            "result": [
                {
                    "team_key": 1,
                    "team_name": "Team A",
                    "team_logo": "logo_url",
                    "players": [],
                    "coaches": []
                }
            ]
        }
        """
        mockNetworkService.mockData = jsonString.data(using: .utf8)
        
     
        let expectation = self.expectation(description: "FetchData")
        networkService.fetchData(from: "test_url", responseType: TeamsResponse.self) { result in
       
            switch result {
            case .success(let teamsResponse):
                XCTAssertEqual(teamsResponse.success, 1)
                XCTAssertEqual(teamsResponse.result?.first?.team_name, "Team A")
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchDataFailure() {
       
        mockNetworkService.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
     
        let expectation = self.expectation(description: "FetchData")
        networkService.fetchData(from: "test_url", responseType: TeamsResponse.self) { result in
        
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
