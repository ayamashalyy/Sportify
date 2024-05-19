//
//  NetworkService.swift
//  Sportify
//
//  Created by aya on 19/05/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://apiv2.allsportsapi.com/football/"
    private let apiKey = "51fb4fba89ac7fb4d039a71fd0d43949585fd598bc57e551715357e78ff32cd7"
    
    private init() {}
    
     func fetchLeagues(sportType sport: String, completionHandler completion: @escaping (Result<LegueResponse>) -> Void) {
        let urlString = "\(baseURL)?met=Leagues&APIkey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        Alamofire.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(LegueResponse.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
