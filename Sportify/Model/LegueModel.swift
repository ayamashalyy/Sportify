//
//  LegueModel.swift
//  Sportify
//
//  Created by aya on 19/05/2024.
//

import Foundation


struct LegueResponse: Codable {
    let success: Int?
    let result: [LegueModel]?
}

struct LegueModel: Codable {
    let league_key: Int?
    let league_name: String?
    let league_logo: String?
    var sportType: String?

}
