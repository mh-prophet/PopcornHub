//
//  MovieGridView.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import SwiftUI

struct MovieGridView: View {
    @EnvironmentObject var vm: HomeViewModel
    @State private var searchText: String = ""
    let columns = [GridItem(.adaptive(minimum: 140), spacing: 12)]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(vm.movies) { movie in
                        NavigationLink(value: movie) {
                            MovieGridItemView(movie: movie)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
            .refreshable {
                vm.loadMovies()
            }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(viewModel: MovieDetailViewModel(movie: movie))
            }
        }
    }
}
