//
//  MovieDetailViewModel.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}
