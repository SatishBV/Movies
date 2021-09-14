//
//  MovieCell.swift
//  MovieCell
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct MovieCell: View {
    var movie: Movie
    
    var body: some View {
        HStack(spacing: 20) {
            moviePoster
            
            VStack(alignment: .leading, spacing: 0) {
                movieTitle
                HStack {
                    movieVotes
                    movieReleaseDate
                }
                movieOverView
            }
        }
    }
    
    private var moviePoster: some View {
        AsyncImage(url: URL(string: movie.posterPathComplete)!) {
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
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
    }
    
    private var movieTitle: some View {
        Text(movie.titleString)
            .font(.system(size: 15))
            .bold()
            .foregroundColor(.blue)
    }
    
    private var movieVotes: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(movie.voteAverageNormalized))
                .stroke(Color.orange, lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.orange.opacity(0.2), lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(-90))
            
            Text(String(format: "%0.2f", movie.voteAverageNormalized))
                .foregroundColor(.orange)
                .font(.subheadline)
        }.frame(height: 80)
    }
    
    private var movieReleaseDate: some View {
        Text(movie.release_date ?? "")
            .foregroundColor(.black)
            .font(.subheadline)
    }
    
    private var movieOverView: some View {
        Text(movie.overview ?? "")
            .font(.system(size: 12))
            .lineLimit(4)
            .foregroundColor(.gray)
    }
}
