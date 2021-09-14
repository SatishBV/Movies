//
//  Movie.swift
//  Movie
//
//  Created by Satish Bandaru on 14/09/21.
//

import Foundation

struct MovieResponse: Codable {
    var results: [Movie]
}

struct Movie: Codable, Identifiable {
    var id: Int?
    var title: String?
    var original_language: String?
    var overview: String?
    var poster_path: String?
    var backdrop_path: String?
    var popularity: Double?
    var vote_average: Double?
    var vote_count: Int?
    var video: Bool?
    var adult: Bool?
    var release_date: String?
    
    var posterPathComplete: String {
        if let path = poster_path {
            return "https://image.tmdb.org/t/p/original/\(path)"
        } else {
            return ""
        }
    }
    
    var voteAverageNormalized: Double {
        if let average = vote_average {
            return average / 10.0
        }
        return 0.0
    }
    
    var titleString: String {
        return title ?? ""
    }
}
