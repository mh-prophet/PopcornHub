//
//  TestDoubles.swift
//  PopcornHubTests
//
//  Created by Mohd on 13/08/25.
//

import Foundation
import Combine
import CoreData
@testable import PopcornHub

// MARK: - Sample Data
struct SampleData {
    static let movie = Movie(id: 1, title: "Sample Movie", overview: "Overview", posterPath: "/poster.jpg", releaseDate: "2025-01-01", voteAverage: 8.5, backdropPath: "/backdrop.jpg", originalTitle: "Sample Movie")
    static let movieList: [Movie] = [
        Movie(id: 1, title: "Sample Movie", overview: "Overview", posterPath: "/poster.jpg", releaseDate: "2025-01-01", voteAverage: 8.5, backdropPath: "/backdrop.jpg", originalTitle: "Sample Movie"),
        Movie(id: 2, title: "Another Movie", overview: "More Overview", posterPath: "/poster2.jpg", releaseDate: "2024-06-01", voteAverage: 7.2, backdropPath: "/backdrop.jpg", originalTitle: "Sample Movie")
    ]
}

// MARK: - MovieRepositoryMock
final class MovieRepositoryMock: MovieRepository {
    var moviesToReturn: [Movie] = []
    var errorToThrow: Error? = nil
    
    func fetchPopular() -> AnyPublisher<[Movie], Error> {
        if let error = errorToThrow {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(moviesToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func search(query: String) -> AnyPublisher<[Movie], Error> {
        if let error = errorToThrow {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(moviesToReturn.filter { $0.title.contains(query) })
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func saveToCache(_ movies: [Movie], replaceExisting: Bool) { }
    func loadCachedMovies() -> [Movie] { return moviesToReturn }
}

// MARK: - Mock URLProtocol
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else { return }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() { }
}

// MARK: - In-Memory PersistenceController
final class InMemoryPersistenceController {
    static func make() -> PersistenceController {
        PersistenceController(inMemory: true)
    }
}
