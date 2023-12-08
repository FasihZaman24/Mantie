//
//  ContentView.swift
//  Mantie
//
//  Created by Muhammad Fasih uz Zaman Siddiqui on 06/12/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    
    
    init() {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = UIColor.white // Set your desired color
            
            // Standard appearance for the tab bar
            UITabBar.appearance().standardAppearance = tabBarAppearance
            
            // Appearance when scrolled (for iOS 15+)
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    
    
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
                .background(Color.white.opacity(0)) // Set the background color for the TabView
                
            
    }
}

#Preview {
    ContentView()
}
