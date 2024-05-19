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

    func fetchLeagues(sportType: String) {
        NetworkManager.shared.fetchLeagues(sportType: sportType) { [weak self] result in
            switch result {
            case .success(let leagueResponse):
                self?.leagues = leagueResponse.result!
                self?.didUpdateLeagues?()
            case .failure(let error):
                self?.didFailWithError?(error)
            }
        }
    }
}
