//
//  HomeView.swift
//  JustBreathe2
//
//  Created by Mitchell Anderson on 9/16/23.
//

import SwiftUI
struct HomeView: View {
    let gradient = LinearGradient(colors: [Color.gray, Color.white], startPoint: .top, endPoint: .bottom)
    
    
    var body: some View {
            NavigationView{
                ZStack {
                    gradient.ignoresSafeArea()
    
                    AQISearchView()
                        .navigationBarTitle("Just Breathe").toolbar {
                            ToolbarItem(placement: .navigation) {
                                Image(systemName: "figure.mind.and.body").padding(.leading)
                            }
                        }
            }
                
            }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


