//
//  NetworkService.swift
//  Sportify
//
//  Created by aya on 19/05/2024.
//

import Foundation
import Alamofire

protocol NetworkService {
    func fetchData<T: Decodable>(from url: String, responseType: T.Type, completionHandler completion: @escaping (Swift.Result<T, Error>) -> Void)
}
class NetworkManager :NetworkService {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(from url: String, responseType: T.Type, completionHandler completion: @escaping (Swift.Result<T, Error>) -> Void) {
        Alamofire.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
