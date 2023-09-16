//
//  FavoriteLocationManager.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import Foundation
class FavoriteLocationManager: ObservableObject {
    
    let key = "FavoriteLocationsList"
    
    
    func addFavorite(city: String, location: [Double]) {
        UserDefaults.standard.set(location, forKey: city)
        
        var FavList = UserDefaults.standard.stringArray(forKey: key) ?? []
        if FavList.contains(city) {
            return
        }
        FavList.append(city)
        
        UserDefaults.standard.set(FavList, forKey: key)
    }
    
    func findFavorite(city: String) -> [Double] {
        if let coordinates = UserDefaults.standard.array(forKey: city) as? [Double] {
            print(coordinates)
            return coordinates
        } else {
            print("You messed up AGAIN")
            return []
        }
    }
}

