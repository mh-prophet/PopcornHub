//
//  MovieDetailView.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let url = viewModel.movie.backdropURL(width: 780) ?? viewModel.movie.posterURL(width: 500) {
                    GeometryReader { geo in
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                Color.gray.opacity(0.3)
                                    .frame(width: geo.size.width, height: 350)
                                    .overlay(ProgressView())
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width, height: 350)
                                    .clipped()
                            case .failure:
                                Color.gray.opacity(0.3)
                                    .frame(width: geo.size.width, height: 350)
                                    .overlay(Image(systemName: "photo").foregroundColor(.white))
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    .frame(height: 350)
                } else {
                    GeometryReader { geo in
                        Color.gray.opacity(0.3)
                            .frame(width: geo.size.width, height: 350)
                            .overlay(Image(systemName: "photo").foregroundColor(.white))
                    }
                    .frame(height: 350)
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(viewModel.movie.title).font(.title2).bold()
                        Spacer()
                        if let rating = viewModel.movie.voteAverage {
                            Text(String(format: "★ %.1f", rating)).foregroundColor(.secondary)
                        }
                    }
                    if let original = viewModel.movie.originalTitle, original != viewModel.movie.title {
                        Text(original).font(.subheadline).foregroundColor(.secondary)
                    }
                    if let year = viewModel.movie.releaseYear {
                        Text("Released: \(year)").font(.subheadline).foregroundColor(.secondary)
                    }
                    if let overview = viewModel.movie.overview, !overview.isEmpty {
                        Text("Overview").font(.headline)
                        Text(overview).font(.body).foregroundColor(.primary)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
