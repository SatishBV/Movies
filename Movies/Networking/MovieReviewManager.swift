//
//  MovieReviewManager.swift
//  MovieReviewManager
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

final class MovieReviewManager: ObservableObject {
    @Published var reviews = [Review]()
    
    private var movie: Movie
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    internal init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieReviews() {
        getReview(for: movie)
    }
    
    private func getReview(for movie: Movie) {
        let urlString = "\(Self.baseURL)\(movie.id ?? 100)/reviews?api_key=\(API.key)"
        NetworkManager<ReviewResponse>.fetch(from: urlString) { result in
            switch result {
            case let .success(response):
                self.reviews = response.results
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
