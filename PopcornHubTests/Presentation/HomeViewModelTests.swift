//
//  HomeViewModelTests.swift
//  PopcornHubTests
//
//  Created by Mohd on 13/08/25.
//

import XCTest
import Combine
@testable import PopcornHub

final class HomeViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var repository: MovieRepositoryMock!
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        repository = MovieRepositoryMock()
        viewModel = HomeViewModel(repository: repository)
    }
    
    func testLoadPopularMoviesUpdatesMoviesList() {
        repository.moviesToReturn = SampleData.movieList
        
        let expectation = XCTestExpectation(description: "Movies list updated")
        
        viewModel.$movies
            .dropFirst()
            .sink { movies in
                XCTAssertEqual(movies.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadMovies()
        wait(for: [expectation], timeout: 1.0)
    }
}
