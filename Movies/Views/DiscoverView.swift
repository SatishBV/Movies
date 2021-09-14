//
//  DiscoverView.swift
//  DiscoverView
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct DiscoverView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    @State private var showDetails = false
    
    @ObservedObject private var movieManager = MovieDownloadManager()
    
    let spacing: CGFloat = 10
    
    var body: some View {
        GeometryReader { geo in
            return ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: spacing) {
                    ForEach(movieManager.movies) { movie in
                        movieCard(movie: movie)
                            .frame(width: geo.size.width)
                    }
                }
            }
            .content.offset(x: self.offset)
            .frame(width: geo.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.offset = value.translation.width - geo.size.width * CGFloat(index)
                    })
                    .onEnded({ value in
                        if -value.predictedEndTranslation.width > geo.size.width / 2, index < movieManager.movies.count - 1 {
                            index += 1
                        }
                        
                        if value.predictedEndTranslation.width > geo.size.width / 2, index > 0 {
                            index -= 1
                        }
                        
                        withAnimation {
                            offset = -(geo.size.width + spacing) * CGFloat(index)
                        }
                    })
            )
        }
        .onAppear {
            movieManager.getPopular()
        }
    }
    
    private func movieCard(movie: Movie) -> some View {
        ZStack(alignment: .bottom) {
            poster(movie: movie)
            detailView(movie: movie)
        }
        .shadow(radius: 12.0)
        .cornerRadius(12)
    }
    
    private func poster(movie: Movie) -> some View {
        AsyncImage(url: URL(string: movie.posterPathComplete)!) {
            Rectangle().foregroundColor(.gray.opacity(0.4))
        } image: { (img) -> Image in
            Image(uiImage: img)
                .resizable()
        }
        .animation(.easeInOut(duration: 0.5))
        .transition(.scale)
        .scaledToFill()
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.75, alignment: .center)
        .cornerRadius(20)
        .shadow(radius: 15)
        .overlay(
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.clear, .clear]), startPoint: .center, endPoint: .bottom))
        )
        .cornerRadius(12)
    }
    
    private func detailView(movie: Movie) -> some View {
        VStack(alignment: .leading) {
            Spacer()
            
            VStack(alignment: .leading) {
                Text(movie.titleString)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top)
                
                Text(movie.overview ?? "")
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top)
                
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    Text("Details")
                        .bold()
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.orange)
                        .cornerRadius(12)
                }.padding()
            }
            .background(Color.white.opacity(0.6))
            .cornerRadius(12)
            .lineLimit(5)
        }.padding()
    }
}
