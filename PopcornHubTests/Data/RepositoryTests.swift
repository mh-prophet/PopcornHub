//
//  RepositoryTests.swift
//  PopcornHubTests
//
//  Created by Mohd on 13/08/25.
//

import XCTest
import Combine
@testable import PopcornHub

final class RepositoryTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var repository: MovieRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = MovieRepositoryMock()
    }
    
    func testFetchPopularReturnsMovies() {
        repository.moviesToReturn = SampleData.movieList
        
        let expectation = XCTestExpectation(description: "Repository returns movies")
        
        repository.fetchPopular()
            .sink(receiveCompletion: { _ in }, receiveValue: { movies in
                XCTAssertEqual(movies.count, 2)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
