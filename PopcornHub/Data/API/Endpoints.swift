//
//  Endpoints.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import Foundation

enum Endpoints {
    static let baseURL = URL(string: "https://api.themoviedb.org/3")!

    case popularMovies(page: Int = 1, language: String = "en-US")
    case searchMovies(query: String, page: Int = 1, language: String = "en-US")

    var path: String {
        switch self {
        case .popularMovies:
            return "movie/popular"
        case .searchMovies:
            return "search/movie"
        }
    }

    var url: URL {
        var components = URLComponents(url: Endpoints.baseURL.appendingPathComponent(path),
                                       resolvingAgainstBaseURL: false)!

        switch self {
        case .popularMovies(let page, let language):
            components.queryItems = [
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "page", value: String(page))
            ]
        case .searchMovies(let query, let page, let language):
            components.queryItems = [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "page", value: String(page))
            ]
        }

        return components.url!
    }
}
