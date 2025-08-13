//
//  HomeViewModel.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var movies: Movies = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""

    private var cancellables = Set<AnyCancellable>()
    private let repository: MovieRepository

    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
        // load cache first
        let cached = repository.loadCachedMovies()
        if !cached.isEmpty {
            self.movies = cached
        }
    }

    func loadMovies() {
        isLoading = true
        errorMessage = nil
        repository.fetchPopular()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.errorMessage = err.localizedDescription
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }

    func search() {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            loadMovies()
            return
        }
        isLoading = true
        errorMessage = nil
        repository.search(query: searchText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.errorMessage = err.localizedDescription
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }
}
