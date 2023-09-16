//
//  LocationState.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import Foundation
enum LoadingState {
    case idle
    case success(AQIModel)
    case loading
    case error(String)
}
