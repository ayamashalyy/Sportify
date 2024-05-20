//
//  LeguesViewModel.swift
//  Sportify
//
//  Created by aya on 19/05/2024.
//

import Foundation

class LeguesViewModel {
    var leagues: [LegueModel] = []
    var didUpdateLeagues: (() -> Void)?
    var didFailWithError: ((Error) -> Void)?
    let baseURL = "https://apiv2.allsportsapi.com/"
    let apiKey = "51fb4fba89ac7fb4d039a71fd0d43949585fd598bc57e551715357e78ff32cd7"
    
    
    func fetchLeagues(for sportType: String) {
        let url = "\(baseURL)\(sportType)/?met=Leagues&APIkey=\(apiKey)"
            NetworkManager.shared.fetchData(from: url, responseType: LegueResponse.self) { [weak self] result in
                switch result {
                case .success(let leagueResponse):
                    self?.leagues = leagueResponse.result ?? []
                    self?.didUpdateLeagues?()
                case .failure(let error):
                    self?.didFailWithError?(error)
                }
            }
        }
        
}
