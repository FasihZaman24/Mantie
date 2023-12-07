//
//  ContentView.swift
//  Mantie
//
//  Created by Muhammad Fasih uz Zaman Siddiqui on 06/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }

                        ReservationView()
                            .tabItem {
                                Label("Reservations", systemImage: "calendar")
                            }

                        MenuView()
                            .tabItem {
                                Label("Menu", systemImage: "list.dash")
                            }
                    }
                    .accentColor(.pink) 
                }
            
    }
}

#Preview {
    ContentView()
}
