//
//  FavoritesView.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import SwiftUI

struct FavoritesView: View {
    var backgroundGradient = LinearGradient(colors: [Color.gray, Color.white], startPoint: .top, endPoint: .bottom)
    @State private var cities: [String] = []
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient.ignoresSafeArea(.all)
                VStack {
                    SearchBar(text: $searchText, isSearching: $isSearching)
                    backgroundGradient.ignoresSafeArea(.all)
                    List {
                        
                        ForEach(cities, id: \.self) { item in
                            NavigationLink(destination: AirDetailsView(city: item)) {
                                Text(item)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if let favorites = UserDefaults.standard.stringArray(forKey: "FavoriteLocationsList") {
                cities = favorites
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $text).padding(.leading, 24)
            
            Button {
                withAnimation {
                    text = ""
                    isSearching = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
            }
            .padding(.trailing)
            
            if isSearching {
                Button {
                    withAnimation {
                        text = ""
                        isSearching = false
                    }
                } label: {
                    Text("Cancel")
                }.transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
        .background(Color(.systemGray))
        .cornerRadius(10)
        .padding(.horizontal)
        .onTapGesture {
            isSearching = true
        }
    }
}
