//
//  MovieDetailView.swift
//  MovieDetailView
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var loader: ImageLoader
    @ObservedObject private var movieManager: MovieDownloadManager = MovieDownloadManager()
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: movie.posterPathComplete)!, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            backgroundView
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    moviePosterView
                    
                    movieOverview
                        .padding(.horizontal, 32)
                    reviewLink
                        .padding(.horizontal, 32)
                    
                    Text("Cast")
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    
                    castInfo
                        .padding(.horizontal, 8)
                    Spacer()
                }
                
            }
        }
        .navigationTitle(Text(movie.titleString))
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var backgroundView: some View {
        imageView.onAppear {
            loader.load()
        }.blur(radius: 100)
    }
    
    private var imageView: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                Rectangle().foregroundColor(.gray.opacity(0.4))
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            Spacer().frame(height: 80)
            Text(movie.titleString)
                .font(.title)
            
            Text("Release Date: \(movie.release_date ?? "-")")
        }.foregroundColor(.white)
    }
    
    private var moviePosterView: some View {
        HStack(alignment: .center) {
            Spacer()
            imageView
                .frame(width: 200, height: 320)
                .cornerRadius(20)
            Spacer()
        }
    }
    
    private var movieOverview: some View {
        Text(movie.overview ?? "-")
            .font(.body)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 16)
    }
    
    private var reviewLink: some View {
        VStack {
            Divider()
            NavigationLink(destination: MovieReviewView(movie: movie)) {
                HStack {
                    Text("Reviews")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            Divider()
        }
    }
    
    private var castInfo: some View {
        VStack(alignment: .leading) {
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    ForEach(movieManager.cast) { cast in
                        VStack {
                            AsyncImage(url: URL(string: cast.profilePhoto)!) {
                                Rectangle().foregroundColor(.gray.opacity(0.4))
                            } image: { (img) -> Image in
                                Image(uiImage: img)
                                    .resizable()
                            }
                            .frame(width: 100, height: 160)
                            .animation(.easeInOut(duration: 0.5))
                            .transition(.opacity)
                            .scaledToFill()
                            .cornerRadius(15)
                            .shadow(radius: 15)
                            
                            Text("\(cast.name ?? "-") as \(cast.character ?? "-")")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 100)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }.onAppear {
            movieManager.getCast(for: movie)
        }
    }
}
