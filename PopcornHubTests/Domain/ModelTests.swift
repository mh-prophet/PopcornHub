//
//  ModelTests.swift
//  PopcornHubTests
//
//  Created by Mohd on 13/08/25.
//

import XCTest
@testable import PopcornHub

final class ModelTests: XCTestCase {
    func testMovieEntityToMovieMapping() {
        let entity = MovieEntity(context: PersistenceController(inMemory: true).container.viewContext)
        entity.id = 1
        entity.title = "Mapped Movie"
        entity.overview = "Overview"
        entity.releaseDate = "2025-01-01"
        entity.posterPath = "/poster.jpg"
        entity.voteAverage = 8.5
        
        let movie = entity.toMovie()
        XCTAssertEqual(movie.id, 1)
        XCTAssertEqual(movie.title, "Mapped Movie")
    }
}
