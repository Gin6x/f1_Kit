//
//  Circuits.swift
//  f1_Kit
//
//  Created by Gin on 9/10/2023.
//

import Foundation

struct Circuits: Codable {
    
    let get: String
    struct Parameters: Codable {
        let search: String
    }
    let parameters: Parameters
    let results: Int
    var response: [CircuitResponses]
}

struct CircuitResponses: Codable {
    
    let name: String
    let laps: Int
    let length: String
    let race_distance: String
    struct Lap_Record: Codable {
        let time: String
        let driver: String
        let year: String
    }
    let lap_record: Lap_Record
}

