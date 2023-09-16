//
//  AQISearchView.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import SwiftUI
import Foundation
var backgroundGradient = LinearGradient(colors: [Color.gray, Color.white], startPoint: .top, endPoint: .bottom)
struct CircularButton: View {
    var action: () -> Void
    
    var body: some View {
        Circle()
            .foregroundColor(Color.gray)
            .frame(width: 200, height: 200)
            .overlay(
                Text("What's my AQI?")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            )
            .onTapGesture {
                action()
            }
    }
}
struct AQISearchView: View {
    @StateObject private var locationManager = FavoriteLocationManager()
    @State private var locationList: [String] = []
    @State private var favorites: [Double] = []
    @StateObject private var vm = AQISearchViewModel()
    @State private var showFavoritesView = false
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient.ignoresSafeArea(.all)
                VStack {
                    CircularButton {
                        vm.getLocation()
                    }
                    .padding()
                    .shadow(radius: 3)
                    
                    switch vm.state {
                    case .idle:
                        Text("No Location to find, Try again later.")
                            .foregroundColor(Color.white)
                    case .loading:
                        ProgressView()
                    case .success(let aqimodel):
                        VStack(alignment: .leading, spacing: 4) {
                            if showFavoritesView {
                                NavigationLink("", destination: FavoritesView(), isActive: $showFavoritesView)
                            }
                            Text("The air quality in \(aqimodel.data.city), \(aqimodel.data.state) \(aqimodel.data.country) is \(aqimodel.data.current.pollution.aqius) and the temperature is \(aqimodel.data.current.weather.tp) degrees Celsius ")
                                .foregroundColor(Color.white)
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray)
                                )
                                .padding(.all)
                            
                            Button(action: {
                                locationList.append(aqimodel.data.city)
                                locationManager.addFavorite(city: aqimodel.data.city, location: aqimodel.data.location.coordinates)
                                print("Pressed")
                                if locationList.count > 0 {
                                    print("Yay")
                                }
                                showFavoritesView = true
                            }) {
                                    Text("Would you like to save \(aqimodel.data.city) as a favorite location?")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(6)
                                        .padding(.horizontal)
                                        .padding(.all)
                                }
                            
                        }
                        .frame(maxWidth: .infinity)
                    case .error(let message):
                        Text(message)
                    }
                }
            }
        }
    }
    
}
struct AQISearchView_Preview: PreviewProvider {
    static var previews: some View {
        AQISearchView()
    }
}
