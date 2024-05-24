//
//  LegueDetailsModel.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 24/05/2024.
//

import Foundation

struct LegueDetailsResponse : Codable{
    let success: Int?
    let result: [LegueDetailsModel]?
}

struct LegueDetailsModel :Codable{
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_key: Int?
    let event_away_team: String?
    let away_team_key: Int?
    let league_name: String?
    let league_key: Int?
    let home_team_logo: String?
    let away_team_logo: String?
}

struct GoalScorer :Codable{
    let score: String?
}
