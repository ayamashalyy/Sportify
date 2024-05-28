//
//  MockNetworkService.swift
//  SportifyTests
//
//  Created by Marim Mohamed Mohamed Yacout on 28/05/2024.
//

import Foundation
protocol NetworkService {
    func fetchData<T: Decodable>(from url: String, responseType: T.Type, completionHandler completion: @escaping (Result<T, Error>) -> Void)
}
class MockNetworkService: NetworkService {
    var mockData: Data?
    var mockError: Error?
    
    func fetchData<T: Decodable>(from url: String, responseType: T.Type, completionHandler completion: @escaping (Result<T, Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let data = mockData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
