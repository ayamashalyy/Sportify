//
//  LeguesDetailsViewModel.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 24/05/2024.
//

import Foundation
class LeguesDetailsViewModel {
    var legueDetails : [LegueDetailsModel] = []
    var didUpdateLegueDetail: (()-> Void)?
    var didFailWithError: ((Error) ->Void)?
    let baseURL = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId="
    
    //https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=[YourKey]
    let apiKey = "51fb4fba89ac7fb4d039a71fd0d43949585fd598bc57e551715357e78ff32cd7"
    
    func fetchLegueDetails(for leagueId:Int){
        let url = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=\(leagueId)&from=2023-01-18&to=2023-02-18&APIkey=51fb4fba89ac7fb4d039a71fd0d43949585fd598bc57e551715357e78ff32cd7"
        NetworkManager.shared.fetchData(from: url, responseType: LegueDetailsResponse.self){
            [weak self] result in
            switch result {
            case .success(let leagueDetailsResponse):
                self?.legueDetails = leagueDetailsResponse.result ?? []
                self?.didUpdateLegueDetail?()
            case .failure(let error):
                self?.didFailWithError?(error)
            }
        }
        
    }
}
