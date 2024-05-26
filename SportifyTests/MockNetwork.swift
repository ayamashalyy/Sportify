////
////  MockNetwork.swift
////  SportifyTests
////
////  Created by Marim Mohamed Mohamed Yacout on 26/05/2024.
////
//import XCTest
//import Alamofire
//@testable import Sportify
//
//class MockNetworkTests: XCTestCase {
//    func testFetchLeagues() {
//        
//        let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=51fb4fba89ac7fb4d039a71fd0d43949585fd598bc57e551715357e78ff32cd7"
//        let expectedLeagues = [
//            LegueModel(league_key: 3, league_name: "UEFA Champions League", league_logo:"https://apiv2.allsportsapi.com/logo/logo_leagues/3_uefa_champions_league.png"),
//            LegueModel(league_key:4, league_name: "UEFA Europa League", league_logo: "https://apiv2.allsportsapi.com/logo/logo_leagues/")
//        ]
//        let expectedResponse = LegueResponse(success: 1, result: expectedLeagues)
//
//        // Mock the Alamofire response
//        let expectation = self.expectation(description: "Fetch leagues")
//        let stubRequest = Alamofire.request(url)
//        stubRequest.responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: value, options: [])
//                    let decodedResponse = try JSONDecoder().decode(LegueResponse.self, from: data)
//                    XCTAssertEqual(decodedResponse.success, 1)
//                    XCTAssertEqual(decodedResponse.result?.count, 2)
//                    XCTAssertEqual(decodedResponse.result?[4].league_key, expectedLeagues[4].league_key)
//                    XCTAssertEqual(decodedResponse.result?[4].league_name, expectedLeagues[4].league_name)
//                    XCTAssertEqual(decodedResponse.result?[4].league_logo, expectedLeagues[4].league_logo)
//                    XCTAssertEqual(decodedResponse.result?[1].league_key, expectedLeagues[1].league_key)
//                    XCTAssertEqual(decodedResponse.result?[1].league_name, expectedLeagues[1].league_name)
//                    XCTAssertEqual(decodedResponse.result?[1].league_logo, expectedLeagues[1].league_logo)
//                } catch {
//                    XCTFail("Unexpected error: \(error)")
//                }
//                expectation.fulfill()
//            case .failure(let error):
//                XCTFail("Unexpected error: \(error)")
//                expectation.fulfill()
//            }
//        }
//
//        // Act
//        NetworkManager.shared.fetchData(from: url, responseType: LegueResponse.self) { result in
//            // No need to do anything here, since the response is already handled in the stubRequest.responseJSON closure
//        }
//
//        // Assert
//        waitForExpectations(timeout: 5.0, handler: nil)
//    }
//}
