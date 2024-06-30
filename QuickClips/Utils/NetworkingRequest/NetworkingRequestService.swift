//
//  NetworkingRequestService.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct NetworkingRequestService: NetworkingRequestProtocol {
    
    func get(from url: URL, queryParams: [String: Any], headers: [String : String]) async throws -> Data {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryParams.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        guard let finalURL = urlComponents.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Invalid response", code: 0, userInfo: nil)
        }
        return data
    }
}
