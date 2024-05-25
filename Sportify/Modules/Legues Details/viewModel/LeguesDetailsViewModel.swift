//
//  LeguesDetailsViewModel.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 24/05/2024.
//

import Foundation
class LeguesDetailsViewModel {
    var legueDetails : [LegueDetailsModel] = []
    var teamData : [TeamsModel] = []
    var didUpdateLegueDetail: (()-> Void)?
    var didFailWithError: ((Error) ->Void)?
    let baseURL = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId="
    
    //https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=[YourKey]
    let apiKey = "51fb4fba89ac7fb4d039a71fd0d43949585fd598bc57e551715357e78ff32cd7"
    
    func fetchUpComingEventsLegueDetails(for leagueId:Int){
        let url = "\(baseURL)\(leagueId)&from=2024-05-18&to=2024-08-18&APIkey=\(apiKey)"
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
    
    func fetchLastestEventsLegueDetails(for leagueId:Int){
        let url = "\(baseURL)\(leagueId)&from=2024-02-18&to=2024-05-18&APIkey=\(apiKey)"
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
    
    func fetchTeams(for leagueId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)"
        NetworkManager.shared.fetchData(from: url, responseType: TeamsResponse.self) { [weak self] result in
            switch result {
            case .success(let teamResponse):
                self?.teamData = teamResponse.result ?? []
                self?.didUpdateLegueDetail?()
                completion(.success(()))
            case .failure(let error):
                self?.didFailWithError?(error)
                completion(.failure(error))
            }
        }
    }
    
    
    func addLeagueToFavorites(league: LegueModel) {
        DataBaseManager.shared.insertLeague(league: league)
        print("League inserted to favorites")
        print("Inserted league: \(league)")
    }
    func removeLeagueFromFavorites(league: LegueModel) {
           DataBaseManager.shared.deleteLeagueItem(league: league)
       }
}
