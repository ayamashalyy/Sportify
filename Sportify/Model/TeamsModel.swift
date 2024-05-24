//
//  TeamsModel.swift
//  Sportify
//
//  Created by Marim Mohamed Mohamed Yacout on 24/05/2024.
//

import Foundation

struct TeamsResponse :Codable{
    let success: Int?
    let result: [TeamsModel]?
}

struct TeamsModel:Codable{
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
}


