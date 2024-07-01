//
//  GetClipsRemoteDataSource.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct GetClipsRemoteDataSource: GetClipsRepository {
    
    let service: NetworkingRequestProtocol
    
    func getClips(page: Int, limit: Int) async throws -> Result<GetClipsSuccessResult, Error> {
        guard let url = URL(string: ApiUrls.getPopularVideos) else {
            return .failure(NSError(domain: "Invalid url", code: 0, userInfo: nil))
        }
        let headers = [
            "Authorization": Configuration.prexelsApiKey,
            "Content-Type": "application/json"
        ]
        let queryParams = [
            "page": page,
            "per_page": limit
        ]
        
        do {
            let data = try await self.service.get(from: url, queryParams: queryParams, headers: headers)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            let feed = try GetClipsDTO(json).getFeed()
            return .success((clips: feed, shouldCacheClips: true))
        } catch {
            return .failure(error)
        }
    }
}
