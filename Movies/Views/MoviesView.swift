//
//  MoviesView.swift
//  MoviesView
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct MoviesView: View {
    
    @State private var searchTerm = ""
    @State private var selectionIndex = 0
    @State private var tabs = ["Now playing", "Upcoming", "Trending"]
    
    @ObservedObject var movieManager = MovieDownloadManager()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchTerm)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
            
            VStack {
                Picker("_", selection: $selectionIndex) {
                    ForEach(0..<tabs.count) { index in
                        Text(tabs[index])
                            .font(.title)
                            .bold()
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectionIndex) { newValue in
                    if selectionIndex == 0 {
                        movieManager.getNowPlaying()
                    } else if selectionIndex == 1 {
                        movieManager.getUpcoming()
                    } else if selectionIndex == 2 {
                        movieManager.getPopular()
                    }
                }
            }
            .padding(.top)
            .padding(.horizontal, 16)
            
            List {
                ForEach(movieManager.movies.filter { searchTerm.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(searchTerm.lowercased()) ?? true }) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieCell(movie: movie)
                    }
                    .frame(minHeight: 200)
                    .listRowBackground(Color.clear)
                }
            }
            .onAppear {
                movieManager.getNowPlaying()
            }
            
            Spacer()
        }
    }
}
