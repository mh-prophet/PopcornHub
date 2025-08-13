//
//  MovieEntity.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import CoreData

@objc(MovieEntity)
public class MovieEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var originalTitle: String?
}

extension MovieEntity {
    func toMovie() -> Movie {
        return Movie(
            id: Int(id),
            title: title,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage == 0 ? nil : voteAverage,
            backdropPath: backdropPath,
            originalTitle: originalTitle
        )
    }
}
