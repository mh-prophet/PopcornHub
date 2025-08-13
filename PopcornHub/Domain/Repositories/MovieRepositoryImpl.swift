//
//  MovieRepositoryImpl.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import Foundation
import CoreData
import Combine

final class MovieRepositoryImpl: MovieRepository {
    private let apiClient: APIClientProtocol
    private let container: NSPersistentContainer
    
    init(apiClient: APIClientProtocol = APIClient(), container: NSPersistentContainer = PersistenceController.shared.container) {
        self.apiClient = apiClient
        self.container = container
    }
    
    func fetchPopular() -> AnyPublisher<Movies, Error> {
        let request = RequestBuilder.request(for: .popularMovies())
        return apiClient.request(request)
            .map { (response: MovieResponse) in
                Movies(response.results)
            }
            .handleEvents(receiveOutput: { [weak self] movies in
                self?.saveToCache(movies, replaceExisting: true)
            })
            .eraseToAnyPublisher()
    }
    
    func search(query: String) -> AnyPublisher<Movies, Error> {
        let request = RequestBuilder.request(for: .searchMovies(query: query))
        return apiClient.request(request)
            .map { (response: MovieResponse) in
                Movies(response.results)
            }
            .eraseToAnyPublisher()
    }
    
    func loadCachedMovies() -> Movies {
        let ctx = container.viewContext
        let req: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        do {
            let ents = try ctx.fetch(req)
            return ents.map { $0.toMovie() }
        } catch {
            print("Core Data fetch error:", error)
            return []
        }
    }
    
    func saveToCache(_ movies: Movies, replaceExisting: Bool = false) {
        let ctx = container.newBackgroundContext()
        ctx.perform {
            if replaceExisting {
                let del = NSBatchDeleteRequest(fetchRequest: MovieEntity.fetchRequest())
                do { try ctx.execute(del) } catch { print("Batch delete failed:", error) }
            }
            
            for movie in movies {
                let fetch: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
                fetch.predicate = NSPredicate(format: "id == %d", movie.id)
                fetch.fetchLimit = 1
                if let existing = (try? ctx.fetch(fetch))?.first {
                    existing.title = movie.title
                    existing.overview = movie.overview
                    existing.posterPath = movie.posterPath
                    existing.backdropPath = movie.backdropPath
                    existing.releaseDate = movie.releaseDate
                    existing.voteAverage = movie.voteAverage ?? 0
                    existing.originalTitle = movie.originalTitle
                } else {
                    let ent = MovieEntity(context: ctx)
                    ent.id = Int64(movie.id)
                    ent.title = movie.title
                    ent.overview = movie.overview
                    ent.posterPath = movie.posterPath
                    ent.backdropPath = movie.backdropPath
                    ent.releaseDate = movie.releaseDate
                    ent.voteAverage = movie.voteAverage ?? 0
                    ent.originalTitle = movie.originalTitle
                }
            }
            
            do { try ctx.save() } catch { print("Core Data save error:", error) }
        }
    }
}
