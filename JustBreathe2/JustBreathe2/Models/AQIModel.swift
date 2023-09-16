//
//  AQIModel.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import Foundation
// MARK: - Welcome
struct AQIModel: Codable {
    let status: String
    let data: DataClass
}
// MARK: - DataClass
struct DataClass: Codable {
    let city, state, country: String
    let location: Location2
    let current: Current
}
// MARK: - Current
struct Current: Codable {
    let pollution: Pollution
    let weather: Weather
}
// MARK: - Pollution
struct Pollution: Codable {
    let ts: String
    let aqius: Int
    let mainus: String
    let aqicn: Int
    let maincn: String
}
// MARK: - Weather
struct Weather: Codable {
    let ts: String
    let tp, pr, hu: Int
    let ws: Double
    let wd: Int
    let ic: String
}
// MARK: - Location
struct Location2: Codable {
    let type: String
    let coordinates: [Double]
}

