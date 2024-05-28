//
//  NetworkTestingTeams.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 28/05/2024.
//

import XCTest
@testable import Sportify
import Alamofire

class NetworkManagerTeamsTests: XCTestCase {

    func testFetchDataWithLegueDetailsResponse() {
        let expectation = self.expectation(description: "Fetching data from network")

        let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=205&APIkey=51fb4fba89ac7fb4d039a71fd0d43949585fd598bc57e551715357e78ff32cd7"

        
        NetworkManager.shared.fetchData(from: url, responseType: LegueDetailsResponse.self) { result in
            switch result {
            case .success(let data):
             
                XCTAssertNotNil(data, "Data should not be nil")
                
                XCTAssertNotNil(data.result, "Result should not be nil")
                if let result = data.result {
                    XCTAssertGreaterThan(result.count, 0, "Result should contain at least one item")
                }
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

