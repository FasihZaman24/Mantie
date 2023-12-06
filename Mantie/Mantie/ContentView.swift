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
            Image("web")
                .imageScale(.large)
                .foregroundStyle(.tint)
                //.resizable()
            Text("Hey Mentiè")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
