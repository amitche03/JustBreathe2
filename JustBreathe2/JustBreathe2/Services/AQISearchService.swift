//
//  AQISearchService.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import Foundation
//Key: 34a9da7c-ff8c-4419-8536-2c39ecc9e5d0
struct AQISearchService {
    private let session: URLSession  = .shared
    public func search(latitude: Double, longitude: Double) async throws -> AQIModel {
        guard let url = URL(string: "https://api.airvisual.com/v2/nearest_city?lat=\(latitude)&lon=\(longitude)&key=34a9da7c-ff8c-4419-8536-2c39ecc9e5d0") else {fatalError("Invalid URL")}
        print("help")
        
        let (data, _) = try await session.data(from: url)
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        let aqimodel = try decoder.decode(AQIModel.self, from: data)
        return aqimodel
    }
}
