//
//  AirDetailsView.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import Foundation
import SwiftUI
struct AirDetailsView: View {
    let city: String
    
    @StateObject private var locationManager = FavoriteLocationManager()
    @StateObject private var vm = AQISearchViewModel()
    
    var body: some View {
        NavigationView {
            
        }.onAppear {
            var coordinates = locationManager.findFavorite(city: city)
            vm.getLocation()
        }
        switch vm.state {
        case .idle:
            Text("No Location to find, Try again later.")
                .foregroundColor(Color.white)
        case .loading:
            ProgressView()
        case .success(let aqimodel):
            VStack(alignment: .leading, spacing: 4) {
                Text("The air quality in \(aqimodel.data.city), \(aqimodel.data.state) \(aqimodel.data.country) is \(aqimodel.data.current.pollution.aqius) and the temperature is \(aqimodel.data.current.weather.tp) degrees Celsius ")
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                    )
                    .padding(.all)
            }
        case .error(let message):
            Text(message)
        }
    }
}
