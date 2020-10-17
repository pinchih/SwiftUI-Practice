//
//  HomeContentView.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/15/20.
//

import SwiftUI

struct HomeContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CardViewContentView(numberOfCards: 5),
                               label: { Text("Poker Cards") })
            }
            .navigationTitle("SwiftUI Practice")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
            .previewDevice("iPhone XR")
    }
}
