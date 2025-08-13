//
//  Models.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import Foundation

typealias Movies = [Movie]

struct MovieResponse: Codable {
    let page: Int
    let results: Movies
    let total_pages: Int?
    let total_results: Int?
}

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let backdropPath: String?
    let originalTitle: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
    }

    var releaseYear: String? {
        guard let releaseDate = releaseDate, !releaseDate.isEmpty else { return nil }
        return String(releaseDate.prefix(4))
    }

    func posterURL(width: Int = 300) -> URL? {
        guard let path = posterPath, !path.trimmingCharacters(in: .whitespaces).isEmpty else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w\(width)\(path)")
    }

    func backdropURL(width: Int = 780) -> URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w\(width)\(path)")
    }
}

extension Movie: Hashable {
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Movie, rhs: Movie) -> Bool { lhs.id == rhs.id }
}
