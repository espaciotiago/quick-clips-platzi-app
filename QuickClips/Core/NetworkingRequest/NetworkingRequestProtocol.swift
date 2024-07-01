//
//  NetworkingRequestProtocol.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

protocol NetworkingRequestProtocol {
    func get(from url: URL, queryParams: [String: Any], headers: [String: String]) async throws -> Data
}
