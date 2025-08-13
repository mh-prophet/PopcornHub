//
//  RequestBuilder.swift
//  PopcornHub
//
//  Created by Mohd on 12/08/25.
//

import Foundation
struct RequestBuilder {
    static var apiToken: String {
        Secrets.bearerToken
    }

    static func request(for endpoint: Endpoints) -> URLRequest {
        var req = URLRequest(url: endpoint.url)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        req.timeoutInterval = 60
        return req
    }
}
