//
//  MovieReviewView.swift
//  MovieReviewView
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct MovieReviewView: View {
    var movie: Movie
    
    @ObservedObject var movieReivewManager: MovieReviewManager
    
    init(movie: Movie) {
        self.movie = movie
        self.movieReivewManager = MovieReviewManager(movie: movie)
        
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.7)
            
            List {
                ForEach(movieReivewManager.reviews) { review in
                    VStack {
                        Text(review.author ?? "")
                            .font(.title)
                            .bold()
                        
                        Text(review.content ?? "")
                            .font(.body)
                            .lineLimit(nil)
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.clear)
                }
            }.onAppear {
                movieReivewManager.getMovieReviews()
            }
            .padding(.horizontal, 32)
        }.edgesIgnoringSafeArea(.all)
    }
}
