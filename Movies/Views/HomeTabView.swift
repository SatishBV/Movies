//
//  HomeTabView.swift
//  HomeTabView
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct HomeTabView: View {
    enum Tab: Int {
        case movie
        case discover
    }
    
    @State private var selectedTab: Tab = .movie
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MoviesView().tabItem {
                tabBarItem(text: "Movies", image: "film")   
            }.tag(Tab.movie)
            
            DiscoverView().tabItem {
                tabBarItem(text: "Discover", image: "square.stack")
            }.tag(Tab.discover)
        }
    }
    
    private func tabBarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            
            Text(text)
        }
    }
}
