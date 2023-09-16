//
//  AQISearchViewModel.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import Foundation
@MainActor
class AQISearchViewModel: ObservableObject {
    private let service = AQISearchService()
    @Published var state: LoadingState = .idle
    
    let locationManager = LocationManager()
    
    init() {
        locationManager.delegate = self
    }
    
    public func getLocation() {
        state = .loading
        locationManager.requestLocation()
        
    }
    
    public func startAQISearch(latitude: Double, longtidude: Double) {
        Task {
            do {
                let result = try await service.search(latitude: latitude, longitude: longtidude)
                state = .success(result)
            }
            catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
extension AQISearchViewModel: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: Location) {
        startAQISearch(latitude: location.latitude, longtidude: location.longitude)
    }
    
    func locationManager(_ manager: LocationManager, didFailError error: Error) {
        state = .error(error.localizedDescription)
    }
}

