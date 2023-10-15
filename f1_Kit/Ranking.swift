//
//  Ranking.swift
//  f1_Kit
//
//  Created by Gin on 3/10/2023.
//

import Foundation

struct Ranking: Codable {
    
    let get: String
    struct Parameters: Codable {
        let season: String
    }
    let parameters: Parameters
    let results: Int
    var response: [RankingResponses]
}

struct RankingResponses: Codable {
    
    let position: Int
    struct Driver: Codable {
        let name: String
    }
    let driver: Driver?
    let team: Team
    let points: Int?
}
