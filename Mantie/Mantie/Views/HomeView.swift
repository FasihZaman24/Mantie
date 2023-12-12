//
//  HomeView.swift
//  Mantie
//
//  Created by Muhammad Fasih uz Zaman Siddiqui on 07/12/23.
//




import SwiftUI
import MapKit



struct HomeView: View {
    @State private var searchText = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.8437368, longitude: 14.2488269),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region) // This creates the live map background
                .ignoresSafeArea()

            SearchBar(searchText: $searchText, region: $region)
                .padding()
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var region: MKCoordinateRegion

    var body: some View {
        TextField("          Search for places", text: $searchText, onCommit: {
            performSearch()
        })
        //.textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
        .overlay(
            ZStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,25)
            })
        
    }
    
    func performSearch() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            // Assuming you want to use the first result and set the map's region to it
            if let firstResult = response.mapItems.first {
                region.center = firstResult.placemark.coordinate
            }
        }
    }
}

#Preview {
    HomeView()
}



































