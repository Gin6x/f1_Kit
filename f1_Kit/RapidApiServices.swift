//
//  RapidApiServices.swift
//  f1_Kit
//
//  Created by Gin on 13/10/2023.
//

import Foundation

class RapidApiServices {
    
    static let shared = RapidApiServices()
    
    enum RapidApiServicesError: Error, LocalizedError {
        
        case networkRespondNotFound
    }
    
//    func getRankingData() async throws -> [Ranking] {
//
//    }
    
    func getCircuitData(circuit: String) async throws -> [CircuitResponses] {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api-formula-1.p.rapidapi.com/circuits?search=\(circuit)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        let headers = [
            "X-RapidAPI-Key": "abc",
            "X-RapidAPI-Host": "api-formula-1.p.rapidapi.com"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw RapidApiServicesError.networkRespondNotFound
        }
        
        let decoder = JSONDecoder()
        let networkResponse = try decoder.decode(Circuits.self, from: data)
        return networkResponse.response
    }
}
