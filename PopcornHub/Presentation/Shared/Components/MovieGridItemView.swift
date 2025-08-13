//
//  MovieGridItemView.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import SwiftUI

struct MovieGridItemView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                if let url = movie.posterURL(width: 300) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            PosterPlaceholderView(title: movie.title)
                                .frame(height: 210)
                        case .success(let img):
                            img
                                .resizable()
                                .scaledToFill()
                                .frame(height: 210)
                                .clipped()
                                .cornerRadius(8)
                        case .failure:
                            PosterPlaceholderView(title: movie.title)
                                .frame(height: 210)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                } else {
                    PosterPlaceholderView(title: movie.title)
                        .frame(height: 210)
                }
            }
            
            Text(movie.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(2)
            
            HStack {
                if let year = movie.releaseYear {
                    Text(year).font(.caption).foregroundColor(.secondary)
                }
                Spacer()
                if let rating = movie.voteAverage {
                    Text(String(format: "★ %.1f", rating))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


