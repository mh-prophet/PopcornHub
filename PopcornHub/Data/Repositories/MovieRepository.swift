//
//  MovieRepository.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//
import Combine
protocol MovieRepository {
    func fetchPopular() -> AnyPublisher<Movies, Error>
    func search(query: String) -> AnyPublisher<Movies, Error>
    func loadCachedMovies() -> Movies
    func saveToCache(_ movies: Movies, replaceExisting: Bool)
}
