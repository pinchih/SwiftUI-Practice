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
                NavigationLink(destination: GridViewContentView(GridViewViewModel(numberOfColumns: 10)),
                               label: { Text("Grid") })
                NavigationLink(destination: FlappyBirdContentView(),
                               label: { Text("Simple Flappy Bird clone") })
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
