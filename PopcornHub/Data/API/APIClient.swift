//
//  APIClient.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error>
}

final class APIClient: APIClientProtocol{
    func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if (200..<300).contains(httpResponse.statusCode) {
                    return data
                }
                else{
                    throw NSError(domain: "Error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: String(data: data, encoding: .utf8) ?? "Unknown Error"])
                }
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
