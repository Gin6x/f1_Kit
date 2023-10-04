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
    var response: [Responses]
}

struct Responses: Codable {
    let position: Int
    struct Driver: Codable {
        let name: String
    }
    let driver: Driver?
    struct Team: Codable {
        let name: String
        let logo: URL
    }
    let team: Team
    let points: Int?
}
