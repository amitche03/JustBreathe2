//
//  AirDetailsView.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import Foundation
import SwiftUI

var backgroundGradient2 = LinearGradient(colors: [Color.gray, Color.white], startPoint: .top, endPoint: .bottom)

struct AirDetailsView: View {
    var backgroundGradient = LinearGradient(colors: [Color.gray, Color.white], startPoint: .top, endPoint: .bottom)
    let city: String
    
    @StateObject private var locationManager = FavoriteLocationManager()
    @StateObject private var vm = AQISearchViewModel()
    
    var body: some View {
        ZStack {
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
                ZStack{
                    backgroundGradient2
                    VStack {
                        Text("\(aqimodel.data.city)").font(.largeTitle).fontWeight(.bold)
                        Text("Temperature: \(aqimodel.data.current.weather.tp) degrees Celsius")
                        Text("Humidity: \(aqimodel.data.current.weather.hu) percent")
                        Text("Air Quality: \(aqimodel.data.current.pollution.aqius)")
                    }
                }
            case .error(let message):
                Text(message)
            }
        }
    }
}
