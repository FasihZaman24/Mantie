//
//  HomeView.swift
//  Mantie
//
//  Created by Muhammad Fasih uz Zaman Siddiqui on 07/12/23.
//




import SwiftUI
import MapKit


// CLASS FOR LOCATION SEARCH DROPDOWN
class LocationSearchCompleter: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var suggestions: [MKLocalSearchCompletion] = []
    var completer: MKLocalSearchCompleter

    override init() {
        completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
    }

    func search(query: String) {
        completer.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        suggestions = completer.results
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle error
        print("Completer failed with error: \(error.localizedDescription)")
    }
}

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
        TextField("        Search for places", text: $searchText, onCommit: {
            performSearch()
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
        .overlay(
            HStack {
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


//struct SuggestionsListView: View {
//    var suggestions: [MKLocalSearchCompletion]
//    var searchCompleter: LocationSearchCompleter
//    @Binding var region: MKCoordinateRegion
//
//    var body: some View {
//        List {
//            ForEach(suggestions, id: \.self) { suggestion in
//                Button(action: {
//                    selectSuggestion(suggestion)
//                }) {
//                    Text(suggestion.title)
//                }
//            }
//        }
//        .listStyle(PlainListStyle())
//    }

#Preview {
    HomeView()
}



































//import SwiftUI
//import MapKit
//
//struct HomeView: View {
//    @State private var searchText = ""
//        @State private var region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Default to Los Angeles, for example
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        )
//
//    var body: some View {
//        VStack {
//            
//            HStack {
//                TextField("Enter location", text: $searchText)
//                    .padding(7)
//                    .padding(.horizontal, 25)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .overlay(
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                .padding(.leading, 8)
//                            
//                            if !searchText.isEmpty {
//                                Button(action: {
//                                    self.searchText = ""
//                                }) {
//                                    Image(systemName: "multiply.circle.fill")
//                                        .foregroundColor(.gray)
//                                        .padding(.trailing, 8)
//                                }
//                            }
//                        }
//                    )
//                    .padding(.horizontal, 10)
//                    .onSubmit {
//                        // Initiate the search with MapKit
//                        //searchInMapKit()
//                    }
//                // Style the TextField to match your design requirements
//            }
//            .padding()
//            
//            Spacer()
//            // Add your additional UI components here
//        }
//        .navigationTitle("Book Luggage Storage")
//        .navigationBarHidden(true)
//    }
//    
//    
//    
//    
//    
//    
//
////    func searchInMapKit() {
////        // Use MapKit's MKLocalSearch to perform the location search
////        let searchRequest = MKLocalSearch.Request()
////        searchRequest.naturalLanguageQuery = searchText
////        
////        let search = MKLocalSearch(request: searchRequest)
////        search.start { (response, error) in
////            guard let response = response else {
////                print("Error: \(error?.localizedDescription ?? "Unknown error").")
////                return
////            }
////
////            // Process the response - for example, update your map view
////            // with the search results, or store them for later use.
////            print(response.mapItems)
////            // You might want to move the map to the first result, etc.
////        }
////    }
//}

