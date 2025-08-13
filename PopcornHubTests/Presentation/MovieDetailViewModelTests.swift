//
//  MovieDetailViewModelTests.swift
//  PopcornHubTests
//
//  Created by Mohd on 13/08/25.
//

import XCTest
import Combine
@testable import PopcornHub

final class MovieDetailViewModelTests: XCTestCase {
    var viewModel: MovieDetailViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MovieDetailViewModel(movie: SampleData.movie)
    }
    
    func testMovieDetailPropertiesMatch() {
        XCTAssertEqual(viewModel.movie.title, "Sample Movie")
        XCTAssertEqual(viewModel.movie.voteAverage, 8.5)
    }
}
